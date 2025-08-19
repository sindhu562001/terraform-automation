project = "red-delight-463218-c6"
project_region = "us-central1"

network_name = "test-vpc-pipeline"
subnets = {
  "subnet-vpc-test-a" = {
    region = "us-central1"
    ip_cidr_range = "10.0.0.0/24"
    },
    subnet-vpc-test-b = {
      region        = "us-central1"
      ip_cidr_range = "10.0.1.0/24"
    }
}
