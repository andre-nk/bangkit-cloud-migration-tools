package utils_test

import (
	"testing"

	"github.com/portierglobal/cloud-migration-tools/rt/client/internal/api"
	utils "github.com/portierglobal/cloud-migration-tools/rt/client/internal/utils/self_update"
	"github.com/stretchr/testify/assert"
)

func TestVersionCheckHeader(t *testing.T) {
	testCases := []struct {
		serverVersion    string
		agentVersion     string
		expectedOutdated bool
	}{
		{"1.2.0", "1.1.0", true},  // Outdated version
		{"1.2.0", "1.2.0", false}, // Not outdated version
	}

	for _, tc := range testCases {
		t.Run(tc.serverVersion+" vs "+tc.agentVersion, func(t *testing.T) {
			req := &api.RequestMessage{
				Headers: api.RequestHeaders{
					Version: tc.serverVersion,
				},
			}

			resp := &api.ReplyMessage{}
			utils.VersionCheckHeader(req, resp, tc.agentVersion)

			assert.Equal(t, tc.agentVersion, resp.Headers.CurrentVersion)
			assert.Equal(t, tc.serverVersion, resp.Headers.LatestVersion)
			assert.Equal(t, tc.expectedOutdated, resp.Headers.Outdated)
		})
	}
}
