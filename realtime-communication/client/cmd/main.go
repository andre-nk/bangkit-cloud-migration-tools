package main

import (
	"encoding/json"
	"fmt"
	"log"
	"time"

	"github.com/nats-io/nats.go"
	"github.com/portierglobal/cloud-migration-tools/rt/client/internal/api"
	"github.com/portierglobal/cloud-migration-tools/rt/client/internal/config"
	"github.com/portierglobal/cloud-migration-tools/rt/client/internal/handler"
	auth_utils "github.com/portierglobal/cloud-migration-tools/rt/client/internal/utils/auth"
	utils "github.com/portierglobal/cloud-migration-tools/rt/client/internal/utils/self_update"
	"github.com/portierglobal/cloud-migration-tools/rt/client/metrics"
)

func main() {
	// Load configuration
	config, err := config.LoadConfig()
	if err != nil {
		log.Fatalf("Failed to load configuration: %v", err)
	}

	//Check for credentials and register
	if err := auth_utils.InitAuth(); err != nil {
		log.Fatalf("Failed to authenticate: %v", err)
	}

	// Connect to a NATS server
	natsURL := "nats://nats:4222" // Use the Docker Compose service name "nats"
	broker, err := nats.Connect(natsURL, nats.UserCredentials(auth_utils.CredsPath))
	if err != nil {
		log.Fatalf("Failed to connect to NATS server: %v", err)
	}

	defer broker.Close()

	// Register Prometheus metrics
	metrics.RegisterMetrics()
	metrics.StartMetricsServer()

	log.Println("Standing by...")

	// Subscribe to the "client123.*" subject
	_, err = broker.Subscribe(
		fmt.Sprintf("%s.*", config.ClientID),
		func(msg *nats.Msg) {
			log.Println("Message received:", string(msg.Data))

			metrics.ReceivedMessages.Inc()
			startTime := time.Now()

			// Parse the incoming request message
			var reqMessage api.RequestMessage
			err := json.Unmarshal(msg.Data, &reqMessage)
			if err != nil {
				log.Printf("Error parsing request message: %v", err)
				metrics.IncrementFailedMessage(startTime)
				return
			}

			// Log the parsed request message
			log.Printf("Parsed request message: %+v", reqMessage)

			// Handle the request based on the type
			var respMessage api.ReplyMessage
			switch reqMessage.Payload.Type {
			case "command":
				respMessage = handler.HandleCommand(&reqMessage)
				break
			case "query":
				respMessage = handler.HandleSQLQuery(&reqMessage, &config.SQL)
				break
			case "download":
				respMessage = handler.HandleFileDownload(&reqMessage, config.DownloadDir)
				break
			default:
				respMessage = handler.HandleUnknownRequest(&reqMessage)
			}

			// Append version header
			utils.VersionCheckHeader(&reqMessage, &respMessage, config.CurrentVersion)

			// Marshal the reply message to JSON
			respBytes, err := json.Marshal(respMessage)
			if err != nil {
				log.Printf("Error marshalling response: %v", err)
				metrics.IncrementFailedMessage(startTime)
				return
			}

			// Respond directly to the original reply subject
			err = msg.Respond(respBytes)
			if err != nil {
				log.Printf("Error sending response: %v", err)
				metrics.IncrementFailedMessage(startTime)
				return
			}

			metrics.IncrementSuccessfulMessage(startTime)
		},
	)

	if err != nil {
		log.Fatalf("Subscription error: %v", err)
	}

	select {}
}
