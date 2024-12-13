package utils

import "github.com/portierglobal/cloud-migration-tools/rt/client/internal/api"

func VersionCheckHeader(req *api.RequestMessage, resp *api.ReplyMessage, currentVersion string) {
	// Update response message header
	resp.Headers = api.ReplyHeaders{
		CurrentVersion: currentVersion,
		LatestVersion:  req.Headers.Version,
		Outdated:       CompareVersions(req.Headers.Version, currentVersion),
	}
}
