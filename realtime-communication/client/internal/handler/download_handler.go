package handler

import (
	"github.com/portierglobal/cloud-migration-tools/rt/client/internal/api"
	services "github.com/portierglobal/cloud-migration-tools/rt/client/internal/services/download"
)

func HandleFileDownload(req *api.RequestMessage, downloadDir string) api.ReplyMessage {
	downloadService := services.NewDownloadService(downloadDir)

	status, response := downloadService.DownloadFile(req.Payload.Command)

	return api.ReplyMessage{
		Payload: api.ReplyPayload{
			Status:   status,
			Response: response,
		},
	}
}
