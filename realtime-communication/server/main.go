package main

import (
	"github.com/labstack/echo/v4"
	"github.com/portierglobal/cloud-migration-tools/rt/server/api"
	"github.com/portierglobal/cloud-migration-tools/rt/server/handler"
	"github.com/portierglobal/cloud-migration-tools/rt/server/message"
	"github.com/portierglobal/cloud-migration-tools/rt/server/metrics"
	"github.com/portierglobal/cloud-migration-tools/rt/server/middleware"
)

func main() {
	e := echo.New()

	e.Use(middleware.AuthMiddleware)

	metrics.RegisterMetrics()

	go message.StartNats()

	handler := &handler.MessageHandler{}

	api.RegisterHandlers(e, handler)

	e.Logger.Fatal(e.Start(":1427"))
}
