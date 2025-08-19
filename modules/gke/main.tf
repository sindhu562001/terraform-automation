resource "google_container_cluster" "gke_lab" {
  name                = var.cluster_name
  location            = var.cluster_location
  initial_node_count  = var.initial_node_count
  deletion_protection = var.deletion_protection
  network             = var.network
  subnetwork          = var.subnet
}