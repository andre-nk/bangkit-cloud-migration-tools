# Build stage
FROM golang:1.23.0-alpine AS builder

# Set working directory
WORKDIR /app

# Install necessary tools for Go build (git for go mod)
RUN apk add --no-cache git

# Copy the Go module files and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the application source code
COPY . .

# Build the Go application
RUN go build -o client-agent ./cmd/main.go

# Final stage: minimal runtime image
FROM alpine:latest

# Install necessary runtime dependencies
# RUN apk add --no-cache bash curl unzip util-linux

# Set working directory
WORKDIR /root/app/

# Install NSC using the precompiled binary
# RUN curl -L https://github.com/nats-io/nsc/releases/download/v2.10.0/nsc-linux-amd64.zip -o nsc.zip \
#     && unzip nsc.zip \
#     && mv nsc /usr/local/bin/ \
#     && chmod +x /usr/local/bin/nsc \
#     && rm -f nsc.zip

# Verify NSC installation
# RUN nsc --version

# Copy the built Go binary from the builder stage
COPY --from=builder /app/client-agent .

# Copy the nsc_envs directory to `../nsc_envs` relative to the binary
RUN mkdir -p ../nsc_envs
COPY nsc_envs/client.creds ../nsc_envs/
# COPY nsc_envs/nats_operator.jwt ../nsc_envs/
# COPY nsc_envs/SYS.jwt ../nsc_envs/

# Copy the script directory to `../script` relative to the binary
RUN mkdir -p ../script
COPY script/register_agent.sh ../script/
RUN chmod +x ../script/register_agent.sh

# Copy the .env file to the current working directory
COPY .env .env

# Expose ports if the application listens
EXPOSE 8080

# Command to run the application
CMD ["./client-agent"]
