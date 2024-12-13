package message

import (
	"encoding/json"
	"fmt"
	"log"
	"time"

	"github.com/nats-io/nats.go"
	"github.com/portierglobal/cloud-migration-tools/rt/server/api"
	"github.com/spf13/viper"
)

var broker *nats.Conn
var natsErr error

func StartNats() {
	// Connect to a NATS server
	natsURL := "nats://nats:4222" // Use the Docker Compose service name "nats"
	broker, natsErr = nats.Connect(natsURL, nats.UserCredentials("../nsc_envs/rt_server_user.creds"))
	if natsErr != nil {
		log.Fatalf("Failed to connect to NATS server: %v", natsErr)
	}
	defer broker.Close()
	log.Println("Connected to NATS")

	select {}
}

func RequestMessage(request api.Request) (respond *api.ReplyMessage, err error) {
	currentVersion, err := checkEnv()
	if err != nil {
		return nil, err
	}

	if natsErr != nil {
		return nil, err
	}

	// Params
	clientID := *request.ClientId // replace from JWT
	userId := *request.UserId
	commandType := *request.Type
	command := *request.Command

	// Header
	header := api.RequestHeaders{
		Version: currentVersion,
	}

	// Request
	reqMessage := api.RequestMessage{
		Headers: header,
		Payload: api.RequestPayload{
			Type:    commandType,
			Command: command,
			Payload: nil,
		},
	}

	// Marshal the request message to JSON
	reqBytes, err := json.Marshal(reqMessage)
	if err != nil {
		log.Printf("Error marshalling request: %v", err)
		return nil, err
	}

	fmt.Println("Sending request...")

	// Send the request message to the client
	resp, err := broker.Request(
		fmt.Sprintf("%s.%s", clientID, userId),
		reqBytes,
		10*time.Second,
	)
	if err != nil {
		log.Printf("Error sending request: %v", err)
		return nil, err
	}

	// Parse the response message
	var respMessage api.ReplyMessage
	err = json.Unmarshal(resp.Data, &respMessage)
	if err != nil {
		log.Printf("Error parsing response: %v", err)
		return nil, err
	}

	// Log the parsed response message
	log.Printf("Received response: %+v", respMessage)
	return &respMessage, nil
}

func checkEnv() (version string, err error) {
	// Set up Viper
	viper.AddConfigPath(".")
	viper.SetConfigName(".env")
	viper.SetConfigType("env")
	viper.AutomaticEnv()

	// Read the config file (environment variables)
	if err := viper.ReadInConfig(); err != nil {
		return "", err
	}

	// Retrieve environment variables
	currentVersion := viper.GetString("RT_SERVER_CURRENT_VERSION")
	if currentVersion == "" {
		return "", fmt.Errorf("RT_SERVER_CURRENT_VERSION is not set")
	}
	return currentVersion, nil
}
