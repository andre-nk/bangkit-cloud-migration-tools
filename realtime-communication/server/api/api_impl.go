package api

import (
	"net/http"

	"github.com/labstack/echo/v4"
)

type Server struct{}

func NewServer() Server {
	return Server{}
}

// (GET /ping)
func (Server) HandleMessage(ctx echo.Context) error {
	resp := Reply{}

	return ctx.JSON(http.StatusOK, resp)
}
