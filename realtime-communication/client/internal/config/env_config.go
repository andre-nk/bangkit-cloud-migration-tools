package config

import (
	"fmt"
	"strings"

	"github.com/spf13/viper"
)

// Config holds all configuration values
type Config struct {
	ClientID       string
	CurrentVersion string
	SQL            SQLConfig
	DownloadDir    string
}

// SQLConfig holds SQL-specific configuration
type SQLConfig struct {
	User     string
	Password string
	Port     string
}

// LoadConfig loads configuration from environment variables and .env file
func LoadConfig() (*Config, error) {
	// Set up Viper
	viper.AddConfigPath(".")
	viper.SetConfigName(".env")
	viper.SetConfigType("env")
	viper.AutomaticEnv()

	// Read the config file
	if err := viper.ReadInConfig(); err != nil {
		// Only log as error if it's not a "config file not found" error
		if _, ok := err.(viper.ConfigFileNotFoundError); !ok {
			return nil, fmt.Errorf("error reading config file: %w", err)
		}
	}

	// Define required fields
	requiredFields := []string{
		"CLIENT_ID",
		"SQL_USER",
		"SQL_PASSWORD",
		"SQL_SERVER_PORT",
		"DOWNLOAD_DIR",
	}

	// Check for missing required fields
	var missingFields []string
	for _, field := range requiredFields {
		if !viper.IsSet(field) {
			missingFields = append(missingFields, field)
		}
	}

	if len(missingFields) > 0 {
		return nil, fmt.Errorf("missing required configuration fields: %s", strings.Join(missingFields, ", "))
	}

	// Create and populate the config struct
	config := &Config{
		ClientID:       viper.GetString("CLIENT_ID"),
		CurrentVersion: viper.GetString("CURRENT_VERSION"), // Optional field
		SQL: SQLConfig{
			User:     viper.GetString("SQL_USER"),
			Password: viper.GetString("SQL_PASSWORD"),
			Port:     viper.GetString("SQL_SERVER_PORT"),
		},
		DownloadDir: viper.GetString("DOWNLOAD_DIR"),
	}

	return config, nil
}
