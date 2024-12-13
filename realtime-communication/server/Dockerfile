# Build stage
FROM golang:1.23.0-alpine AS builder

# Set working directory
WORKDIR /app

# Install necessary tools for Go build (if needed, such as git for go mod)
RUN apk add --no-cache git

# Copy the Go module files and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the application source code
COPY . .

# Build the Go application
RUN go build -o server ./main.go

# Final stage: minimal runtime image
FROM alpine:latest

# Set working directory
WORKDIR /root/app/

# Install necessary runtime dependencies (if any are required)
RUN apk add --no-cache bash

# Copy the built Go binary from the builder stage
COPY --from=builder /app/server .

# Copy the nsc_envs directory to `../nsc_envs` relative to the binary
RUN mkdir -p ../nsc_envs
COPY ./nsc_envs/rt_server_user.creds ../nsc_envs/

# Copy the .env file to the current working directory
COPY .env .env

# Expose ports if the application listens
EXPOSE 1427

# Command to run the application
CMD ["./server"]
