variable "project" {
  type = string
  default = "red-delight-463218-c6"
}

variable "project_region" {
  type = string
  default = "us-central1"
}

variable "network_name" {
  type = string
  default = "my-vpc"
}

variable "subnets" {
  type = map(object({
    region = string
    ip_cidr_range = string
  }))
}

