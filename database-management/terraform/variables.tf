variable "instance_name" {
  type        = string
  description = "Name for the Google Compute instance"
  default     = "postgres"
}
variable "instance_zone" {
  type        = string
  description = "Zone for the Google Compute instance"
  default     = "asia-southeast2-b"
}
variable "instance_region" {
  type        = string
  description = "Zone for the Google Compute instance"
  default     = "asia-southeast2"
}
variable "instance_type" {
  type        = string
  description = "Disk type of the Google Compute instance"
  default     = "e2-micro"
}

variable "project_id" {
  type        = string
  description = "project id"
  default     = "portier-cloud-migration-tools"
}