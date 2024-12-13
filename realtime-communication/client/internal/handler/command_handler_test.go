package handler

import (
	"strings"
	"testing"

	"github.com/portierglobal/cloud-migration-tools/rt/client/internal/api"
)

func TestHandleCommand(t *testing.T) {
	tests := []struct {
		name           string
		command        string
		expectedStatus int
		expectedOutput string
		expectError    bool
	}{
		{
			name:           "Valid Command - Echo",
			command:        "echo Hello, World!",
			expectedStatus: 200,
			expectedOutput: "Hello, World!\n",
			expectError:    false,
		},
		{
			name:           "Invalid Command",
			command:        "nonexistentcommand",
			expectedStatus: 500,
			expectedOutput: "exit status", // Look for "exit status" rather than exact text
			expectError:    true,
		},
		{
			name:           "Empty Command",
			command:        "",
			expectedStatus: 500,
			expectedOutput: "command cannot be empty",
			expectError:    true,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			req := &api.RequestMessage{
				Payload: api.RequestPayload{
					Command: tt.command,
				},
			}

			resp := HandleCommand(req)

			// Check status
			if resp.Payload.Status != tt.expectedStatus {
				t.Errorf("expected status %d, got %d", tt.expectedStatus, resp.Payload.Status)
			}

			// Check output or error message
			if tt.expectError {
				if !strings.Contains(resp.Payload.Response, tt.expectedOutput) {
					t.Errorf("expected error containing %q, got %q", tt.expectedOutput, resp.Payload.Response)
				}
			} else {
				if resp.Payload.Response != tt.expectedOutput {
					t.Errorf("expected output %q, got %q", tt.expectedOutput, resp.Payload.Response)
				}
			}
		})
	}
}
