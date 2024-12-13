package handler

import "github.com/portierglobal/cloud-migration-tools/rt/client/internal/api"

func HandleUnknownRequest(req *api.RequestMessage) api.ReplyMessage {
	return api.ReplyMessage{
		Payload: api.ReplyPayload{
			Status:   400,
			Response: "Unknown request type",
		},
	}
}
