package main

import (
	"bytes"
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/labstack/echo/v4"
	"github.com/portierglobal/cloud-migration-tools/rt/server/api"
	"github.com/portierglobal/cloud-migration-tools/rt/server/handler"
	"github.com/portierglobal/cloud-migration-tools/rt/server/message"
	"github.com/portierglobal/cloud-migration-tools/rt/server/metrics"
	"github.com/portierglobal/cloud-migration-tools/rt/server/middleware"
	"github.com/stretchr/testify/assert"
)

// NewServer initializes a new Echo server for testing
func NewServer() *echo.Echo {
	e := echo.New()

	// Use your middleware
	e.Use(middleware.AuthMiddleware)

	// Register your metrics
	metrics.RegisterMetrics()

	// Initialize NATS in a separate goroutine
	go message.StartNats()

	// Initialize your handler
	handler := &handler.MessageHandler{}

	// Register your routes (API handlers)
	api.RegisterHandlers(e, handler)

	return e
}

// TestCommandEndpoint_ValidRequest tests a valid command request
func TestCommandEndpoint_ValidRequest(t *testing.T) {
	e := NewServer()

	// Create a valid request payload
	request := map[string]interface{}{
		"client_id": "client123",
		"user_id":   "user1",
		"type":      "command",
		"command":   "ls",
	}
	reqBytes, _ := json.Marshal(request)

	// Create the HTTP request
	req := httptest.NewRequest(http.MethodPost, "/command", bytes.NewReader(reqBytes))
	req.Header.Set("Authorization", "m2m_token valid_token") //Change valid_token to a valid m2m token
	req.Header.Set("Content-Type", "application/json")

	// Record the response
	rec := httptest.NewRecorder()
	e.ServeHTTP(rec, req)

	// Assertions
	assert.Equal(t, http.StatusOK, rec.Code)
	var response map[string]interface{}
	err := json.Unmarshal(rec.Body.Bytes(), &response)
	assert.NoError(t, err)
	assert.Equal(t, "Success", response["response"])
}

// TestCommandEndpoint_InvalidPayload tests the case when the payload is invalid
func TestCommandEndpoint_InvalidPayload(t *testing.T) {
	e := NewServer()

	// Create an invalid request payload (missing required fields)
	request := map[string]interface{}{
		"client_id": "client123",
	}
	reqBytes, _ := json.Marshal(request)

	// Create the HTTP request
	req := httptest.NewRequest(http.MethodPost, "/command", bytes.NewReader(reqBytes))
	req.Header.Set("Authorization", "m2m_token valid_token") //Change valid_token to a valid m2m token
	req.Header.Set("Content-Type", "application/json")

	// Record the response
	rec := httptest.NewRecorder()
	e.ServeHTTP(rec, req)

	// Assertions
	assert.Equal(t, http.StatusBadRequest, rec.Code)
	var response map[string]interface{}
	err := json.Unmarshal(rec.Body.Bytes(), &response)
	assert.NoError(t, err)
	assert.Contains(t, response["response"], "Type and Command cannot be empty")
}

// TestCommandEndpoint_MissingAuthorization tests the case where the Authorization header is missing
func TestCommandEndpoint_MissingAuthorization(t *testing.T) {
	e := NewServer()

	// Create a valid request payload
	request := map[string]interface{}{
		"client_id": "client123",
		"user_id":   "abc",
		"type":      "command",
		"command":   "ls",
	}
	reqBytes, _ := json.Marshal(request)

	// Create the HTTP request without Authorization header
	req := httptest.NewRequest(http.MethodPost, "/command", bytes.NewReader(reqBytes))
	req.Header.Set("Content-Type", "application/json") //Change valid_token to a valid m2m token

	// Record the response
	rec := httptest.NewRecorder()
	e.ServeHTTP(rec, req)

	// Assertions
	assert.Equal(t, http.StatusUnauthorized, rec.Code)
	var response map[string]interface{}
	err := json.Unmarshal(rec.Body.Bytes(), &response)
	assert.NoError(t, err)
	assert.Contains(t, response["message"], "missing header")
}

// TestCommandEndpoint_InvalidAuthorizationFormat tests the case where the Authorization header has an invalid format
func TestCommandEndpoint_InvalidAuthorizationFormat(t *testing.T) {
	e := NewServer()

	// Create a valid request payload
	request := map[string]interface{}{
		"client_id": "client123",
		"user_id":   "abc",
		"type":      "command",
		"command":   "ls",
	}
	reqBytes, _ := json.Marshal(request)

	// Create the HTTP request with invalid Authorization header
	req := httptest.NewRequest(http.MethodPost, "/command", bytes.NewReader(reqBytes))
	req.Header.Set("Authorization", "InvalidFormat")
	req.Header.Set("Content-Type", "application/json")

	// Record the response
	rec := httptest.NewRecorder()
	e.ServeHTTP(rec, req)

	// Assertions
	assert.Equal(t, http.StatusBadRequest, rec.Code)
	var response map[string]interface{}
	err := json.Unmarshal(rec.Body.Bytes(), &response)
	assert.NoError(t, err)
	assert.Contains(t, response["message"], "invalid header format")
}

// TestCommandEndpoint_NatsIntegration tests the integration of NATS with the command endpoint
func TestCommandEndpoint_NatsIntegration(t *testing.T) {
	e := NewServer()

	// Create a valid request payload
	request := map[string]interface{}{
		"client_id": "client123",
		"user_id":   "abc",
		"type":      "command",
		"command":   "ls",
	}
	reqBytes, _ := json.Marshal(request)

	// Create the HTTP request
	req := httptest.NewRequest(http.MethodPost, "/command", bytes.NewReader(reqBytes))
	req.Header.Set("Authorization", "m2m_token valid_token") //Change valid_token to a valid m2m token
	req.Header.Set("Content-Type", "application/json")

	// Record the response
	rec := httptest.NewRecorder()
	e.ServeHTTP(rec, req)

	// Assertions
	assert.Equal(t, http.StatusOK, rec.Code)
	var response map[string]interface{}
	err := json.Unmarshal(rec.Body.Bytes(), &response)
	assert.NoError(t, err)
	assert.Equal(t, "Success", response["response"])
}
