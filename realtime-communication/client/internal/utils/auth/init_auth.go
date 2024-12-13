package utils

import (
	"fmt"
	"os"
	"os/exec"
)

const (
	CredsPath       = "../nsc_envs/client.creds"
	ProvisionScript = "../script/register_agent.sh" // Relative path from cmd
)

func InitAuth() error {
	fmt.Println(os.Getwd())

	if _, err := os.Stat(CredsPath); os.IsNotExist(err) {
		fmt.Println("Credentials file not found. Attempting to provision...")

		// Run provisioning script
		cmd := exec.Command("bash", ProvisionScript)
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr
		if err := cmd.Run(); err != nil {
			return fmt.Errorf("failed to execute provisioning script: %w", err)
		}

		fmt.Println("Provisioning completed successfully.")
	}
	return nil
}
