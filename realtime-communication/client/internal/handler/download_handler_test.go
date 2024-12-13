package handler_test

import (
	"io/ioutil"
	"os"
	"path/filepath"
	"strings"
	"testing"

	"github.com/portierglobal/cloud-migration-tools/rt/client/internal/api"
	"github.com/portierglobal/cloud-migration-tools/rt/client/internal/handler"
)

func TestHandleFileDownload(t *testing.T) {
	// Test file URL - using a small LICENSE file from a public GitHub repo
	testFileURL := "https://raw.githubusercontent.com/golang/go/master/LICENSE"

	tests := []struct {
		name             string
		url              string
		expectedStatus   int
		expectedResponse string
		expectError      bool
		validateContent  bool
	}{
		{
			name:             "Valid File Download",
			url:              testFileURL,
			expectedStatus:   200,
			expectedResponse: "File downloaded and saved successfully",
			expectError:      false,
			validateContent:  true,
		},
		{
			name:             "Invalid URL",
			url:              "http://invalid-url-that-does-not-exist.com/file.txt",
			expectedStatus:   500,
			expectedResponse: "Failed to download file",
			expectError:      true,
			validateContent:  false,
		},
		{
			name:             "Empty URL",
			url:              "",
			expectedStatus:   500,
			expectedResponse: "Invalid URL provided",
			expectError:      true,
			validateContent:  false,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			// Create a temporary directory for each test
			downloadDir, err := ioutil.TempDir("", "download_test_")
			if err != nil {
				t.Fatalf("Failed to create temp directory: %v", err)
			}
			defer os.RemoveAll(downloadDir) // Clean up after test

			// Create a mock request message with the test URL
			req := &api.RequestMessage{
				Payload: api.RequestPayload{
					Command: tt.url,
				},
			}

			// Call the HandleFileDownload function
			resp := handler.HandleFileDownload(req, downloadDir)

			// Check the status code
			if resp.Payload.Status != tt.expectedStatus {
				t.Errorf("expected status %d, got %d", tt.expectedStatus, resp.Payload.Status)
			}

			// Check if the response contains the expected message
			if tt.expectError {
				if !strings.Contains(resp.Payload.Response, tt.expectedResponse) {
					t.Errorf("expected response containing %q, got %q", tt.expectedResponse, resp.Payload.Response)
				}
			} else {
				if resp.Payload.Response != tt.expectedResponse {
					t.Errorf("expected response %q, got %q", tt.expectedResponse, resp.Payload.Response)
				}
			}

			// For valid downloads, verify the file exists and contains content
			if tt.validateContent {
				// Get the downloaded file (should be named LICENSE)
				files, err := os.ReadDir(downloadDir)
				if err != nil {
					t.Fatalf("Failed to read download directory: %v", err)
				}

				if len(files) != 1 {
					t.Errorf("Expected 1 file in download directory, got %d", len(files))
					return
				}

				downloadedFile := filepath.Join(downloadDir, files[0].Name())
				content, err := os.ReadFile(downloadedFile)
				if err != nil {
					t.Fatalf("Failed to read downloaded file: %v", err)
				}

				// Verify file is not empty and contains expected content
				if len(content) == 0 {
					t.Error("Downloaded file is empty")
				}
			}
		})
	}
}
