resource "google_storage_bucket" "state_storage_bucket" {
  name          = var.bucket_name
  location      = var.bucket_location
  force_destroy = var.force_destroy
}