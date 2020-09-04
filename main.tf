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
