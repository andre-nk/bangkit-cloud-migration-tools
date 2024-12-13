// file_utils.go
package utils

import (
	"net/http"
	"net/url"
	"path/filepath"
	"strings"
)

func DetermineFileName(parsedURL *url.URL, resp *http.Response) string {
	fileName := filepath.Base(parsedURL.Path)
	if fileName == "" || fileName == "/" || fileName == "." {
		if cd := resp.Header.Get("Content-Disposition"); strings.Contains(cd, "filename=") {
			fileName = strings.Split(cd, "filename=")[1]
			fileName = strings.Trim(fileName, `"'`)
		}
		if fileName == "" {
			fileName = "downloaded_file"
		}
	}
	return SanitizeFileName(fileName)
}

func SanitizeFileName(name string) string {
	unsafe := []string{"/", "\\", ":", "*", "?", "\"", "<", ">", "|"}
	safeName := name
	for _, char := range unsafe {
		safeName = strings.ReplaceAll(safeName, char, "_")
	}
	return safeName
}
