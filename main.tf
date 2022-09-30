terraform {
  required_required_version = "1.3.1"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.38.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region = var.region
  impersonate_service_account = "terraform-service@${var.project_id}.iam.gserviceaccount.com"
}