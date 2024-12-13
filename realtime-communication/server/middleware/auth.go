package middleware

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"strings"

	"github.com/labstack/echo/v4"
)

type UserMeResponse struct {
	User UserMe `json:"user"`
}

type UserMe struct {
	PK                int      `json:"pk"`
	Username          string   `json:"username"`
	Name              string   `json:"name"`
	IsActive          bool     `json:"is_active"`
	IsSuperuser       bool     `json:"is_superuser"`
	Groups            []Group  `json:"groups"`
	Email             string   `json:"email"`
	Avatar            string   `json:"avatar"`
	UID               string   `json:"uid"`
	Settings          struct{} `json:"settings"`
	Type              string   `json:"type"`
	SystemPermissions []string `json:"system_permissions"`
}

type Group struct {
	PK          string   `json:"pk"`
	NumPK       int      `json:"num_pk"`
	Name        string   `json:"name"`
	IsSuperuser bool     `json:"is_superuser"`
	Parent      *string  `json:"parent"`
	ParentName  *string  `json:"parent_name"`
	Attributes  struct{} `json:"attributes"`
}

func AuthMiddleware(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		// Bypass authentication for the /metrics path
		if c.Path() == "/metrics" {
			return next(c)
		}

		// Get token from Authorization header
		reqHeader := c.Request().Header.Get("Authorization")
		if reqHeader == "" {
			return echo.NewHTTPError(http.StatusUnauthorized, "missing header "+reqHeader)
		}

		parts := strings.SplitN(reqHeader, " ", 2)
		if len(parts) != 2 {
			return echo.NewHTTPError(http.StatusBadRequest, "invalid header format")
		}
		authType := strings.ToLower(parts[0])
		authToken := parts[1]

		if authType != "m2m_token" {
			return echo.NewHTTPError(http.StatusBadRequest, fmt.Sprintf("Type not supported: %s", authType))
		}

		data, err := getUser(authToken, "GET")
		if err != nil {
			return echo.NewHTTPError(http.StatusUnauthorized, fmt.Sprintf("failed to get user data: %v", err))
		}

		c.Set("user", data.User)

		return next(c)
	}

}

func getUser(token string, method string) (UserMeResponse, error) {
	url := "https://auth-stg.portierglobal.com/api/v3/core/users/me/"
	req, err := http.NewRequest(method, url, nil)
	if err != nil {
		return UserMeResponse{}, fmt.Errorf("error creating request: %v", err)
	}

	req.Header.Set("Authorization", "Bearer "+token)
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Accept", "application/json")

	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		return UserMeResponse{}, err
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return UserMeResponse{}, fmt.Errorf(resp.Status)
	}

	bodyBytes, err := io.ReadAll(resp.Body)
	if err != nil {
		return UserMeResponse{}, err
	}

	var userResponse UserMeResponse
	if err := json.Unmarshal(bodyBytes, &userResponse); err != nil {
		return UserMeResponse{}, err
	}

	return userResponse, nil
}
