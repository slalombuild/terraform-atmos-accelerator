terraform {
  required_version = ">=1.3"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=4.72.0, < 5.0"
    }
  }
}
