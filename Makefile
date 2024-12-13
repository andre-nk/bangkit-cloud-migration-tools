DB_COMPOSE_FILE = database-management/infrastructure/local/docker-compose.yml
RT_COMPOSE_FILE = realtime-communication/infrastructure/local/docker-compose.yml
RT_CLIENT_DIRECTORY = realtime-communication/client/cmd
RT_SERVER_DIRECTORY = realtime-communication/server

.PHONY: db rt up

db:
	docker compose -f $(DB_COMPOSE_FILE) up

rt:
	docker compose -f $(RT_COMPOSE_FILE) up

rt-b:
	docker compose -f $(RT_COMPOSE_FILE) up --build

run-rt-c:
	cd $(RT_CLIENT_DIRECTORY) && air

run-rt-s:
	cd $(RT_SERVER_DIRECTORY) && air

up: db rt
