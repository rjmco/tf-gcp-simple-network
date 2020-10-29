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

output "nat_ips" {
  description = "List of external IP addresses allocated to the Cloud NAT instance"
  value       = google_compute_router_nat.nat_router_config.nat_ips
}

output "nat_router_name" {
  description = "Cloud NAT router's name"
  value       = google_compute_router.nat_router.name
}

output "nat_router_self_link" {
  description = "Cloud NAT router's selfLink"
  value       = google_compute_router.nat_router.self_link
}

output "network_name" {
  description = "VPC network name"
  value       = google_compute_network.network.name
}

output "network_self_link" {
  description = "VPC network selfLink"
  value       = google_compute_network.network.self_link
}

output "subnetwork_name" {
  description = "Subnetwork's name"
  value       = google_compute_subnetwork.subnetwork.name
}

output "subnetwork_self_link" {
  description = "Subnetwork's selfLink"
  value       = google_compute_subnetwork.subnetwork.self_link
}
