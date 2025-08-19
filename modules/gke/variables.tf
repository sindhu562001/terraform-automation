variable "cluster_name" {
  type = string
}

variable "cluster_location" {
  type = string
}

variable "initial_node_count" {
  type = number
}

variable "deletion_protection" {
  type = bool
}

variable "network" {
  type = string
}

variable "subnet" {
  type = string
}
