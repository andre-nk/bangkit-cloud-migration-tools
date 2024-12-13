package handler

import (
	"os/exec"
	"runtime"

	"github.com/portierglobal/cloud-migration-tools/rt/client/internal/api"
)

func HandleCommand(req *api.RequestMessage) api.ReplyMessage {
	// Check if the command is empty
	if req.Payload.Command == "" {
		return api.ReplyMessage{
			Payload: api.ReplyPayload{
				Status:   500,
				Response: "command cannot be empty",
			},
		}
	}

	var cmd *exec.Cmd

	// Detect the operating system
	if runtime.GOOS == "windows" {
		// Use "cmd" for Windows
		cmd = exec.Command("cmd", "/C", req.Payload.Command)
	} else {
		// Use "bash" for non-Windows systems
		cmd = exec.Command("bash", "-c", req.Payload.Command)
	}

	// Execute the command
	out, err := cmd.Output()
	if err != nil {
		return api.ReplyMessage{
			Payload: api.ReplyPayload{
				Status:   500,
				Response: err.Error(),
			},
		}
	}

	return api.ReplyMessage{
		Payload: api.ReplyPayload{
			Status:   200,
			Response: string(out),
		},
	}
}
