# Cloud Migration Tools

Monorepo for several cloud migration tools. Including database management, realtime communication and user migrations.

## Setup and Development

- Using Linux, MacOS or WSL, install nix package manager

```
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

- Clone this repo and install all system dependencies (e.g. Language and tooling) with nix (defined in [flake.nix](./flake.nix)). Confirm by checking the version

```
cd cloud-migration-tools
nix develop
go version
```

- Run backing service (if needed)

```bash
# for db
docker compose -f database-management/infrastructure/local/docker-compose.yml up

# for rt
docker compose -f realtime-communication/infrastructure/local/docker-compose.yml up
```

- Run the app locally

```
air
```

## Sending Request Using Postman

1. Open Postman and create a new request.
2. Set the method to `POST` and enter the endpoint URL (e.g., `http://localhost:1427/command`).
3. In the "Headers" section, add:
   - `Authorization`: `m2m_token [Your Token]`
4. In the "Body" section, select "raw" and enter the JSON payload with the value:
   ```json
   {
    "clientId": "[Value]",
    "userId": "[Value]",
    "type": "[Value]",
    "command": "[Value]"
   }
   ```
5. Click "Send" to send the request. You should see the response in the bottom panel.
