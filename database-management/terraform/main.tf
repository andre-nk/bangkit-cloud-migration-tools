terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }

  backend "gcs" {
    bucket  = "portier-cloud-migration-tools"
    prefix  = "terraform/state"
  }
}

provider "google" {

  project = var.project_id
  region  = var.instance_region
  zone    = var.instance_zone
}

resource "google_storage_bucket" "db_bucket" {
  name        = var.project_id
  location    = "ASIA-SOUTHEAST2"
  uniform_bucket_level_access = true
}

resource "google_compute_address" "static" {
  name = "ipv4-address"
}

resource "google_compute_instance" "postgres" {
  name         = "postgres"
  machine_type = "e2-small"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network    = "cloud-migration-tool-stg"
    subnetwork = "public-subnet"
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
  allow_stopping_for_update = true
  tags                      = ["db-server", "http-server", "https-server"]
  metadata_startup_script   = file("./startup.sh")
}

# module "vpc" {
#   source  = "terraform-google-modules/network/google"
#   version = "~> 6.0"

#   project_id   = var.project_id
#   network_name = "vpc-database"

#   subnets = [
#     {
#       subnet_name   = "sub-database"
#       subnet_ip     = "10.121.10.0/24"
#       subnet_region = var.instance_region
#     }
#   ]
# }

resource "google_compute_firewall" "rules" {
  project     = var.project_id
  name        = "allow-access"
  network     = "cloud-migration-tool-stg"
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "5432", "3000-3003", "7700"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["db-server"]
}
