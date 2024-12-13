package integration

import (
	"encoding/json"
	"log"
	"testing"
	"time"

	"github.com/nats-io/nats.go"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"

	"github.com/portierglobal/cloud-migration-tools/rt/client/internal/api"
	"github.com/portierglobal/cloud-migration-tools/rt/client/internal/config"
	"github.com/portierglobal/cloud-migration-tools/rt/client/internal/handler"
)

// TestHandleSQLQueryWithSQLServer tests the HandleSQLQuery handler with SQL Server
func TestHandleSQLQueryWithSQLServer(t *testing.T) {
	// Generate configuration based on the provided ENV file
	cfg := &config.Config{
		ClientID:       "client123",
		CurrentVersion: "1.0.0",
		SQL: config.SQLConfig{
			User:     "sa",
			Password: "1234qwerASDF",
			Port:     "1433",
		},
		DownloadDir: "./downloads",
	}

	// Setup NATS connection
	natsURL := "nats://localhost:4222" // Adjust if needed
	clientID := cfg.ClientID           // Use the client ID from the configuration
	testSubject := clientID + ".sqlquery"

	nc, err := nats.Connect(natsURL, nats.UserCredentials("../../../nsc_envs/client.creds"))
	require.NoError(t, err, "Failed to connect to NATS server")
	defer nc.Close()

	// Spin up the actual NATS subscription in a goroutine
	go func() {
		_, err := nc.Subscribe(testSubject, func(msg *nats.Msg) {
			// Log the received message
			log.Println("Server received message:", string(msg.Data))

			// Parse the request message
			var reqMessage api.RequestMessage
			err := json.Unmarshal(msg.Data, &reqMessage)
			require.NoError(t, err, "Failed to parse request in server")

			// Call the actual handler with the loaded SQL config
			respMessage := handler.HandleSQLQuery(&reqMessage, &cfg.SQL)

			// Marshal the response
			respBytes, err := json.Marshal(respMessage)
			require.NoError(t, err, "Failed to marshal server response")

			// Send the response back to the client
			err = msg.Respond(respBytes)
			require.NoError(t, err, "Failed to respond to client")
		})
		require.NoError(t, err, "Failed to subscribe to NATS subject")
	}()

	// Wait a moment for the subscription to activate
	time.Sleep(1 * time.Second)

	// Prepare the test request with an SQL query
	request := api.RequestMessage{
		Payload: api.RequestPayload{
			Type:    "sqlquery",
			Command: "CREATE TABLE TestTable (ID INT PRIMARY KEY, Name NVARCHAR(50)); INSERT INTO TestTable (ID, Name) VALUES (1, 'John Doe'); SELECT * FROM TestTable;",
		},
	}
	requestBytes, err := json.Marshal(request)
	require.NoError(t, err, "Failed to marshal request message")

	// Publish the SQL query request and wait for the response
	respMsg, err := nc.Request(testSubject, requestBytes, 5*time.Second)
	require.NoError(t, err, "Failed to get response from NATS server")

	// Validate the response
	var respMessage api.ReplyMessage
	err = json.Unmarshal(respMsg.Data, &respMessage)
	require.NoError(t, err, "Failed to unmarshal response message")

	// Assertions
	assert.Equal(t, 200, respMessage.Payload.Status, "Expected status 200")
	assert.Contains(t, respMessage.Payload.Response, "SQL query executed successfully", "Response should indicate success")
	assert.NotNil(t, respMessage.Payload.Payload, "Payload should contain query results")
}
