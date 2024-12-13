package handler_test

import (
	"testing"

	"github.com/portierglobal/cloud-migration-tools/rt/client/internal/api"
	"github.com/portierglobal/cloud-migration-tools/rt/client/internal/handler"
	"github.com/stretchr/testify/assert"
)

func TestHandleUnknownRequest(t *testing.T) {
	// Create a mock request
	req := &api.RequestMessage{
		Payload: api.RequestPayload{
			Command: "unknown", // Simulating an unknown request
		},
	}

	// Call the function
	res := handler.HandleUnknownRequest(req)

	// Check if the response status is 400 (Bad Request)
	assert.Equal(t, 400, res.Payload.Status)

	// Check if the response message is "Unknown request type"
	assert.Equal(t, "Unknown request type", res.Payload.Response)
}
