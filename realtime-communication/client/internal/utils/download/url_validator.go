package utils

import "net/url"

func ValidateURL(u *url.URL) bool {
	return u != nil && (u.Scheme == "http" || u.Scheme == "https") && u.Host != ""
}
