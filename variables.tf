# Copyright 2020 Ricardo Cordeiro <ricardo.cordeiro@tux.com.pt>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

variable "nat_router_name" {
  default     = "nat-router"
  description = "Cloud NAT router name"
  type        = string

  validation {
    condition     = can(regex("^(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?)$", var.nat_router_name))
    error_message = "The router name must be a match of regex '(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?)'."
  }
}

variable "network_name" {
  default     = "network"
  description = "VPC network name"
  type        = string

  validation {
    condition     = can(regex("^(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?)$", var.network_name))
    error_message = "The network name must be a match of regex '(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?)'."
  }
}

variable "project_id" {
  description = "Project ID where resources should be hosted on"
  type        = string

  validation {
    condition     = can(regex("^(?:[a-z][-a-z0-9]{4}(?:[-a-z0-9]{0,23})?[a-z0-9])$", var.project_id))
    error_message = "The project ID must be a match of regex '^(?:[a-z][-a-z0-9]{4}(?:[-a-z0-9]{0,23})?[a-z0-9])$'."
  }
}

variable "region" {
  default     = "europe-west2"
  description = "Region where regional resources should be deployed on"

  validation {
    condition = (contains([
      "asia-east1",
      "asia-east2",
      "asia-northeast1",
      "asia-northeast2",
      "asia-northeast3",
      "asia-south1",
      "asia-southeast1",
      "asia-southeast2",
      "australia-southeast1",
      "europe-north1",
      "europe-west1",
      "europe-west2",
      "europe-west3",
      "europe-west4",
      "europe-west6",
      "northamerica-northeast1",
      "southamerica-east1",
      "us-central1",
      "us-east1",
      "us-east4",
      "us-west1",
      "us-west2",
      "us-west3",
      "us-west4"
    ], var.region))
    error_message = "Region needs to be a valid GCP region."
  }
}

variable "subnetwork_ip_cidr_range" {
  default     = "192.168.0.0/24"
  description = "Subnetwork IP CIDR range"
  type        = string

  validation {
    # Checks for a valid IP CIDR range, even though only the RFC 1918 ones are acceptable.
    condition     = can(cidrnetmask(var.subnetwork_ip_cidr_range))
    error_message = "The subnetwork_ip_cidr_range variable needs to be a valid RFC 1918 IP CIDR range."
  }
}

variable "subnetwork_name" {
  default     = "subnetwork"
  description = "Subnetwork name"
  type        = string
  validation {
    condition     = can(regex("^(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?)$", var.subnetwork_name))
    error_message = "Subnetwork name must be a match of regex '^(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?)$'."
  }
}
