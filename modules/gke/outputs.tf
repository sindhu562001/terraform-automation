output "cluster_endpoint" {
  value = google_container_cluster.gke_lab.endpoint
}

output "cluster_name" {
  value = google_container_cluster.gke_lab.name
}