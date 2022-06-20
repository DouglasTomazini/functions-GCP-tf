terraform {
  required_providers {
    google = {
        source = "hashicorp/google"
        version = "3.85.0"
    }
  }
}

provider "google" {
  project = "delta-trees-352617"
  region = "us-central1"
  zone = "us-central1-a"
}



