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
	"github.com/portierglobal/cloud-migration-tools/rt/client/internal/handler"
)

func TestHandleUnknownRequest(t *testing.T) {
	// NATS connection setup
	natsURL := "nats://localhost:4222" // Adjust if needed
	clientID := "testClient123"        // Use the client ID from the configuration
	testSubject := clientID + ".unknown"

	nc, err := nats.Connect(natsURL, nats.UserCredentials("../../../nsc_envs/client.creds"))
	require.NoError(t, err, "Failed to connect to NATS server")
	defer nc.Close()

	// Spin up a goroutine for the NATS subscription
	go func() {
		_, err := nc.Subscribe(testSubject, func(msg *nats.Msg) {
			// Log the received message
			log.Println("Server received message:", string(msg.Data))

			// Parse the request message
			var reqMessage api.RequestMessage
			err := json.Unmarshal(msg.Data, &reqMessage)
			require.NoError(t, err, "Failed to parse request in server")

			// Call the unknown handler
			respMessage := handler.HandleUnknownRequest(&reqMessage)

			// Marshal the response
			respBytes, err := json.Marshal(respMessage)
			require.NoError(t, err, "Failed to marshal server response")

			// Send the response back to the client
			err = msg.Respond(respBytes)
			require.NoError(t, err, "Failed to respond to client")
		})
		require.NoError(t, err, "Failed to subscribe to NATS subject")
	}()

	// Allow time for the subscription to activate
	time.Sleep(1 * time.Second)

	// Prepare a test request with an unknown type
	request := api.RequestMessage{
		Payload: api.RequestPayload{
			Type:    "unknown_type",
			Command: "some_unknown_command",
		},
	}
	requestBytes, err := json.Marshal(request)
	require.NoError(t, err, "Failed to marshal request message")

	// Publish the request and wait for a response
	respMsg, err := nc.Request(testSubject, requestBytes, 5*time.Second)
	require.NoError(t, err, "Failed to get response from NATS server")

	// Validate the response
	var respMessage api.ReplyMessage
	err = json.Unmarshal(respMsg.Data, &respMessage)
	require.NoError(t, err, "Failed to unmarshal response message")

	// Assertions
	assert.Equal(t, 400, respMessage.Payload.Status, "Expected status 400 for unknown request")
	assert.Equal(t, "Unknown request type", respMessage.Payload.Response, "Response should indicate unknown request type")
}
