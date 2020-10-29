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

resource "google_compute_network" "network" {
  name = var.network_name

  auto_create_subnetworks = false
  project                 = var.project_id

}

resource "google_compute_subnetwork" "subnetwork" {
  ip_cidr_range = var.subnetwork_ip_cidr_range
  name          = var.subnetwork_name
  network       = google_compute_network.network.self_link

  private_ip_google_access = true
  project                  = var.project_id
  region                   = var.region
}

resource "google_compute_router" "nat_router" {
  name    = var.nat_router_name
  network = google_compute_network.network.self_link

  project = var.project_id
  region  = var.region
}

resource "google_compute_router_nat" "nat_router_config" {
  name                               = var.nat_router_name
  nat_ip_allocate_option             = "AUTO_ONLY"
  router                             = google_compute_router.nat_router.name
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  project = var.project_id
  region  = var.region
}
