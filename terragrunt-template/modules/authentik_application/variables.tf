variable "name" {
  type        = string
  description = "Name of the application"
}

variable "slug" {
  type        = string
  description = "Slug for the application"
}

variable "authentication_flow" {
  type        = string
  description = "Authentication flow slug"
  default = "default-authentication-flow"
}

variable "authorization_flow" {
  type        = string
  description = "Authorization flow slug"
  default = "default-provider-authorization-implicit-consent"
}

variable "redirect_uris" {
  type        = list(string)
  description = "List of allowed redirect URIs"
}

variable "meta_launch_url" {
  type        = string
  description = "Application launch URL"
  default     = ""
}