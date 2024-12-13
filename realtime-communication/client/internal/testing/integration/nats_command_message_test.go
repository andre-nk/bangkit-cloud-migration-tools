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

// TestNATSValidCommandMessage tests the actual NATS handler
func TestNATSValidCommandMessage(t *testing.T) {
	// Setup NATS connection
	natsURL := "nats://localhost:4222" // Adjust to your setup
	clientID := "testClient123"        // Test-specific client ID
	testSubject := clientID + ".command"

	nc, err := nats.Connect(natsURL, nats.UserCredentials("../../../nsc_envs/client.creds"))
	require.NoError(t, err, "Failed to connect to NATS server")
	defer nc.Close()

	// Spin up your actual handler for the "testClient123.*" subject
	go func() {
		_, err := nc.Subscribe(testSubject, func(msg *nats.Msg) {
			// Call your actual handler here
			log.Println("Server received message:", string(msg.Data))

			// Parse the request
			var reqMessage api.RequestMessage
			err := json.Unmarshal(msg.Data, &reqMessage)
			require.NoError(t, err, "Failed to parse request in server")

			// Use your real handler for the request
			respMessage := handler.HandleCommand(&reqMessage)

			// Marshal the response
			respBytes, err := json.Marshal(respMessage)
			require.NoError(t, err, "Failed to marshal server response")

			// Respond back to the client
			err = msg.Respond(respBytes)
			require.NoError(t, err, "Failed to respond to client")
		})
		require.NoError(t, err, "Failed to subscribe to test subject")
	}()

	// Wait a moment for the subscription to activate
	time.Sleep(1 * time.Second)

	// Client-side logic: Prepare test request
	request := api.RequestMessage{
		Payload: api.RequestPayload{
			Type:    "command",
			Command: "echo 'hello world'",
		},
	}
	requestBytes, err := json.Marshal(request)
	require.NoError(t, err, "Failed to marshal request message")

	// Publish the command message and wait for the response
	respMsg, err := nc.Request(testSubject, requestBytes, 5*time.Second)
	require.NoError(t, err, "Failed to get response from NATS server")

	// Validate the response
	var respMessage api.ReplyMessage
	err = json.Unmarshal(respMsg.Data, &respMessage)
	require.NoError(t, err, "Failed to unmarshal response message")

	assert.Equal(t, 200, respMessage.Payload.Status, "Expected status 200")
	assert.Contains(t, respMessage.Payload.Response, "hello world", "Response should include command output")
}
