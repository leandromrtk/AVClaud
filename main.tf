provider "google" {
  credentials = file("GCP_CREDENTIALS") # arquivo gerado no workflow
  project     = "sabor-caseiro-456406"
  region      = "southamerica-east1"
}


resource "google_app_engine_application" "app" {
  project     = "sabor-caseiro-456406"
  location_id = "southamerica-east1"
}

resource "google_storage_bucket" "app_bucket" {
  name          = "sabor-caseiro-bucket"
  location      = "US"
  force_destroy = true
}
