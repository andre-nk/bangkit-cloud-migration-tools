package services

import (
	"fmt"
	"io"
	"net/http"
	"net/url"
	"os"
	"path/filepath"

	utils "github.com/portierglobal/cloud-migration-tools/rt/client/internal/utils/download"
)

type DownloadService struct {
	downloadDir string
}

func NewDownloadService(downloadDir string) *DownloadService {
	os.MkdirAll(downloadDir, os.ModePerm) // Ensure directory exists
	return &DownloadService{downloadDir: downloadDir}
}

func (ds *DownloadService) DownloadFile(fileURL string) (int, string) {
	parsedURL, err := url.Parse(fileURL)
	if err != nil || !utils.ValidateURL(parsedURL) {
		return 400, "Invalid URL provided"
	}

	// Send GET request
	resp, err := http.Get(fileURL)
	if err != nil || resp.StatusCode != http.StatusOK {
		return 500, fmt.Sprintf("Failed to download file: %v", err)
	}
	defer resp.Body.Close()

	// Determine file name
	fileName := utils.DetermineFileName(parsedURL, resp)
	filePath := filepath.Join(ds.downloadDir, fileName)

	// Create file and save content
	file, err := os.Create(filePath)
	if err != nil {
		return 500, fmt.Sprintf("Failed to create file: %v", err)
	}
	defer file.Close()

	_, err = io.Copy(file, resp.Body)
	if err != nil {
		return 500, fmt.Sprintf("Failed to write file content: %v", err)
	}

	return 200, "File downloaded and saved successfully"
}
