output "vpc_self_link" {
  value = google_compute_network.vpc.self_link
}

output "subnet_self_link" {
  value = { for key, subnet in google_compute_subnetwork.vpc_subnet :
  key => subnet.self_link }
}
