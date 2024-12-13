package integration

import (
	"encoding/json"
	"os"
	"testing"
	"time"

	"github.com/nats-io/nats.go"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"

	"github.com/portierglobal/cloud-migration-tools/rt/client/internal/api"
	"github.com/portierglobal/cloud-migration-tools/rt/client/internal/handler"
)

// TestHandleFileDownload tests the actual NATS handler for file download
func TestHandleFileDownload(t *testing.T) {
	// Setup NATS connection
	natsURL := "nats://localhost:4222" // Adjust to your setup
	clientID := "testClient123"        // Test-specific client ID
	testSubject := clientID + ".download"

	nc, err := nats.Connect(natsURL, nats.UserCredentials("../../../nsc_envs/client.creds"))
	require.NoError(t, err, "Failed to connect to NATS server")
	defer nc.Close()

	// Spin up the real handler for "testClient123.*" subject
	go func() {
		_, err := nc.Subscribe(testSubject, func(msg *nats.Msg) {
			// Log the received message
			t.Log("Server received message:", string(msg.Data))

			// Parse the request message
			var reqMessage api.RequestMessage
			err := json.Unmarshal(msg.Data, &reqMessage)
			require.NoError(t, err, "Failed to parse request in server")

			// Call the actual handler to handle file download
			// The handler will take care of the URL download
			downloadDir := "/tmp/test-downloads" // Specify a download directory
			respMessage := handler.HandleFileDownload(&reqMessage, downloadDir)

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

	// Step 1: Client-side logic: Prepare the test request with the URL
	request := api.RequestMessage{
		Payload: api.RequestPayload{
			Type:    "download",
			Command: "https://filesamples.com/samples/code/c/sample3.c", // Use the actual URL
		},
	}
	requestBytes, err := json.Marshal(request)
	require.NoError(t, err, "Failed to marshal request message")

	// Step 2: Publish the download request and wait for the response
	respMsg, err := nc.Request(testSubject, requestBytes, 5*time.Second)
	require.NoError(t, err, "Failed to get response from NATS server")

	// Step 3: Validate the response
	var respMessage api.ReplyMessage
	err = json.Unmarshal(respMsg.Data, &respMessage)
	require.NoError(t, err, "Failed to unmarshal response message")

	// Assertions: Check status and response
	assert.Equal(t, 200, respMessage.Payload.Status, "Expected status 200")
	assert.Contains(t, respMessage.Payload.Response, "File downloaded and saved successfully", "Response should contain success message")

	// Optionally, check if the file is downloaded in the download directory
	downloadedFilePath := "/tmp/test-downloads/sample3.c"
	_, err = os.Stat(downloadedFilePath)
	assert.NoError(t, err, "Downloaded file should exist")
}
