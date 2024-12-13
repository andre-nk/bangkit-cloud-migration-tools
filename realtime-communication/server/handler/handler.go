package handler

import (
	"fmt"
	"net/http"
	"time"

	"github.com/labstack/echo/v4"
	"github.com/portierglobal/cloud-migration-tools/rt/server/api"
	"github.com/portierglobal/cloud-migration-tools/rt/server/message"
	"github.com/portierglobal/cloud-migration-tools/rt/server/metrics"
)

type MessageHandler struct{}

// /command POST
func (h *MessageHandler) HandleCommand(ctx echo.Context) error {
	start := time.Now()
	elapsed := time.Since(start).Seconds()

	var request api.Request

	err := ctx.Bind(&request)
	if err != nil {
		metrics.ResponseErrors.Inc()
		metrics.HttpRequestsTotal.WithLabelValues("400").Inc()
		return ctx.JSON(http.StatusBadRequest, api.Reply{
			Response: "Invalid request payload",
		})
	}

	if request.Type == nil || request.Command == nil {
		metrics.ResponseErrors.Inc()
		metrics.HttpRequestsTotal.WithLabelValues("400").Inc()
		return ctx.JSON(http.StatusBadRequest, api.Reply{
			Response: "Type and Command cannot be empty",
		})
	}

	replyMsg, err := message.RequestMessage(request)
	metrics.MsgsSentToClient.Inc()
	if err != nil {
		metrics.ResponseErrors.Inc()
		metrics.HttpRequestsTotal.WithLabelValues("400").Inc()
		return ctx.JSON(http.StatusBadRequest, api.Reply{
			Response: err.Error(),
		})
	}
	if replyMsg != nil {
		metrics.ResponsesReceivedFromClient.Inc()
		metrics.ResponseLatency.Observe(elapsed)
		metrics.HttpRequestsTotal.WithLabelValues(fmt.Sprintf("%v", replyMsg.Payload.Status)).Inc()
		return ctx.JSON(replyMsg.Payload.Status, api.Reply{
			Response: replyMsg.Payload.Response,
		})
	}

	metrics.ResponseErrors.Inc()
	metrics.HttpRequestsTotal.WithLabelValues("503").Inc()
	return ctx.JSON(http.StatusServiceUnavailable, api.Reply{
		Response: "Service is currently unavailable, please try again later.",
	})
}
