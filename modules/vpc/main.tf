resource "google_compute_network" "vpc" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnet" {
  for_each      = var.subnets
  name          = each.key
  region        = each.value.region
  ip_cidr_range = each.value.ip_cidr_range
  network       = google_compute_network.vpc.self_link

  dynamic "secondary_ip_range" {
    for_each = each.value.secondary_ranges != null ? each.value.secondary_ranges : []
    content {
      range_name    = secondary_ip_range.value.range_name
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
    }
  }
}

resource "google_compute_firewall" "allow-ssh" {
  name    = "${var.network_name}-allow-ssh"
  network = google_compute_network.vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  direction     = "INGRESS"
}
/*
########################################
# Cloud NAT (no changes to existing code)
########################################

# Collect distinct regions from your subnets map
locals {
  nat_regions = toset([for s in values(var.subnets) : s.region])
}

# One Cloud Router per region
resource "google_compute_router" "nat_router" {
  for_each = local.nat_regions

  name    = "${var.network_name}-${each.value}-router"
  network = google_compute_network.vpc.self_link
  region  = each.value
}

# One Cloud NAT per region, for all subnets & all ranges
resource "google_compute_router_nat" "nat" {
  for_each = local.nat_regions

  name   = "${var.network_name}-${each.value}-nat"
  router = google_compute_router.nat_router[each.value].name
  region = each.value

  # Let GCP allocate ephemeral external IPs for NAT
  nat_ip_allocate_option = "AUTO_ONLY"

  # NAT every subnet (primary + secondary) in the region
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  # Helpful logs (only errors) – change to ALL if you want more detail
  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }

  # Ensure subnets exist before NAT evaluates which ranges to include
  depends_on = [google_compute_subnetwork.vpc_subnet]
}

*/