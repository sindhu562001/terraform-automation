provider "google" {
  project = var.project
  region  = var.project_region
  #  credentials = file("$HOME/secret-key.json")
}

module "vpc" {
  source       = "../../modules/vpc"
  network_name = "${var.network_name}-${terraform.workspace}"
  subnets = {
    subnet-vpc-dev-a = {
      region        = "us-central1"
      ip_cidr_range = "10.1.0.0/24"
      secondary_ranges = [
      {
        range_name    = "pods-range"
        ip_cidr_range = "10.30.0.0/16"
      },
      {
        range_name    = "services-range"
        ip_cidr_range = "10.40.0.0/20"
      }
    ]
    },
    subnet-vpc-dev-b = {
      region        = "us-central1"
      ip_cidr_range = "10.2.2.0/24"
    }
  }
}

output "subnet-self-link" {
  value = module.vpc.subnet_self_link["subnet-vpc-a"]
}

/*
module "gke_lab" {
  source = "../modules/gke"
  cluster_name = "my-gke-cluster"
  cluster_location = "us-central1"
  initial_node_count = 1
  deletion_protection = false
  network = module.vpc.vpc_self_link
  subnet = module.vpc.subnet_self_link["subnet-vpc-a"]
}
*/
