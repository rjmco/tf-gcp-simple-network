variable "nat_router_name" {
  default     = "nat-router"
  description = "Cloud NAT router name"
  type        = string
}

variable "network_name" {
  default     = "network"
  description = "VPC network name"
  type        = string
}

variable "project_id" {
  description = "Project ID where resources should be hosted on"
  type        = string
}

variable "region" {
  default     = "europe-west2"
  description = "Region where regional resources should be deployed on"
}

variable "subnetwork_ip_cidr_range" {
  default     = "192.168.0.0/24"
  description = "Subnetwork IP CIDR range"
  type        = string
}

variable "subnetwork_name" {
  default     = "subnetwork"
  description = "Subnetwork name"
  type        = string
}
