variable "network_name" {
  type = string
}

variable "subnets" {
  description = "Map of subnets and their configs"
  type = map(object({
    region          = string
    ip_cidr_range   = string
    secondary_ranges = optional(list(object({
      range_name    = string
      ip_cidr_range = string
    })))
  }))
}
