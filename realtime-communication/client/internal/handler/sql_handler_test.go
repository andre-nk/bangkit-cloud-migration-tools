package handler_test

import (
	"fmt"
	"testing"

	_ "github.com/denisenkom/go-mssqldb" // SQL Server driver
	"github.com/portierglobal/cloud-migration-tools/rt/client/internal/api"
	"github.com/portierglobal/cloud-migration-tools/rt/client/internal/config"
	"github.com/portierglobal/cloud-migration-tools/rt/client/internal/handler"
	"github.com/stretchr/testify/assert"
)

func TestHandleSQLQuery(t *testing.T) {
	// Helper function to create a request message
	makeRequest := func(command string) api.RequestMessage {
		return api.RequestMessage{
			Payload: api.RequestPayload{
				Command: command,
			},
		}
	}

	// Test cases with sample queries
	tests := []struct {
		name           string
		command        string
		expectedStatus int
	}{
		{
			name:           "Insert Record",
			command:        "INSERT INTO AUSFUEHRUNG (AUSFUEHRUNG_ID, BEZEICHNUNG, ANLAGEDATUM, LETZTEAENDERUNG) VALUES (1, 'Sample Entry', '2023-01-01 10:00:00', '2023-01-01 10:00:00')",
			expectedStatus: 200,
		},
		{
			name:           "Select All Records",
			command:        "SELECT * FROM AUSFUEHRUNG",
			expectedStatus: 200,
		},
		{
			name:           "Filter by BEZEICHNUNG",
			command:        "SELECT * FROM AUSFUEHRUNG WHERE BEZEICHNUNG = 'Sample Entry'",
			expectedStatus: 200,
		},
		{
			name:           "Update Record",
			command:        "UPDATE AUSFUEHRUNG SET BEZEICHNUNG = 'Updated Entry', LETZTEAENDERUNG = GETDATE() WHERE AUSFUEHRUNG_ID = 1",
			expectedStatus: 200,
		},
		{
			name:           "Sort Records by ANLAGEDATUM",
			command:        "SELECT * FROM AUSFUEHRUNG ORDER BY ANLAGEDATUM DESC",
			expectedStatus: 200,
		},
		{
			name:           "Find Records Modified After Date",
			command:        "SELECT * FROM AUSFUEHRUNG WHERE LETZTEAENDERUNG > '2023-01-01 00:00:00'",
			expectedStatus: 200,
		},
		{
			name:           "Count Total Records",
			command:        "SELECT COUNT(*) AS TotalRecords FROM AUSFUEHRUNG",
			expectedStatus: 200,
		},
		{
			name:           "Retrieve Latest Modified Record",
			command:        "SELECT TOP 1 * FROM AUSFUEHRUNG ORDER BY LETZTEAENDERUNG DESC",
			expectedStatus: 200,
		},
		{
			name:           "Get Distinct BEZEICHNUNG Values",
			command:        "SELECT DISTINCT BEZEICHNUNG FROM AUSFUEHRUNG",
			expectedStatus: 200,
		},
	}

	// Run tests
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			req := makeRequest(tt.command)

			mockSQLConfig := &config.SQLConfig{
				User:     "sa",
				Password: "1234qwerASDF",
				Port:     "1433",
			}

			resp := handler.HandleSQLQuery(&req, mockSQLConfig)

			// Assert that the response status is as expected
			assert.Equal(t, tt.expectedStatus, resp.Payload.Status, fmt.Sprintf("Unexpected status for test case %s", tt.name))
		})
	}
}
