package utils

import (
	"strconv"
	"strings"
)

// CompareVersions returns true if version1 is greater than version2, otherwise false.
func CompareVersions(serverStatus, agentStatus string) bool {
	v1Parts := strings.Split(serverStatus, ".")
	v2Parts := strings.Split(agentStatus, ".")
	maxLen := max(len(v1Parts), len(v2Parts))

	for i := 0; i < maxLen; i++ {
		v1Segment := 0
		v2Segment := 0

		if i < len(v1Parts) {
			v1Segment, _ = strconv.Atoi(v1Parts[i])
		}
		if i < len(v2Parts) {
			v2Segment, _ = strconv.Atoi(v2Parts[i])
		}

		if v1Segment > v2Segment {
			return true
		} else if v1Segment < v2Segment {
			return false
		}
	}
	return false
}

// max returns the maximum of two integers.
func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
