package api

import (
	"fmt"
	"strings"
)

// RequestMessage represents the Request message from the AsyncAPI contract
type RequestMessage struct {
	Headers RequestHeaders `json:"headers"`
	Payload RequestPayload `json:"payload"`
}

// RequestHeaders represents the headers of the Request message
type RequestHeaders struct {
	Version string `json:"version"`
}

// RequestPayload represents the payload of the Request message
type RequestPayload struct {
	Type    string      `json:"type"`
	Command string      `json:"command"`
	Payload interface{} `json:"payload"`
}

// ReplyMessage represents the Reply message from the AsyncAPI contract
type ReplyMessage struct {
	Headers ReplyHeaders `json:"headers"`
	Payload ReplyPayload `json:"payload"`
}

// ReplyHeaders represents the headers of the Reply message
type ReplyHeaders struct {
	CurrentVersion string `json:"current_version"`
	LatestVersion  string `json:"latest_version"`
	Outdated       bool   `json:"outdated"`
}

// ReplyPayload represents the payload of the Reply message
type ReplyPayload struct {
	Status   int         `json:"status"`
	Response string      `json:"response"`
	Payload  interface{} `json:"payload"`
}

// Address represents the channel address from the AsyncAPI contract
type Address struct {
	ClientID string
	UserID   string
}

// NewAddress creates a new Address from the given clientID and userID
func NewAddress(clientID, userID string) Address {
	return Address{
		ClientID: clientID,
		UserID:   userID,
	}
}

// String returns the address in the format "${clientID}.{userID}"
func (a Address) String() string {
	return fmt.Sprintf("%s.%s", a.ClientID, a.UserID)
}

// ParseAddress parses the address string and returns a new Address
func ParseAddress(address string) (Address, error) {
	parts := strings.Split(address, ".")
	if len(parts) != 2 {
		return Address{}, fmt.Errorf("invalid address format: %s", address)
	}
	return Address{
		ClientID: parts[0],
		UserID:   parts[1],
	}, nil
}
