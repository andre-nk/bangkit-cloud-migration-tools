package handler

import (
	"log"

	"github.com/portierglobal/cloud-migration-tools/rt/client/internal/api"
	"github.com/portierglobal/cloud-migration-tools/rt/client/internal/config"
	services "github.com/portierglobal/cloud-migration-tools/rt/client/internal/services/database"
)

func HandleSQLQuery(req *api.RequestMessage, sqlConfig *config.SQLConfig) api.ReplyMessage {
	sqlService, err := services.NewSQLService(sqlConfig)
	if err != nil {
		log.Printf("Error initializing SQLService: %v", err)
		return api.ReplyMessage{
			Payload: api.ReplyPayload{
				Status:   500,
				Response: "Failed to connect to the database",
			},
		}
	}
	defer sqlService.Close()

	// Execute the SQL query
	results, err := sqlService.ExecuteQuery(req.Payload.Command)
	if err != nil {
		log.Printf("Error executing SQL query: %v", err)
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
			Response: "SQL query executed successfully",
			Payload:  results,
		},
	}
}
