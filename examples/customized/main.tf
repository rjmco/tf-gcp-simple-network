module "network" {
  source     = "../../"
  project_id = var.project_id

  nat_router_name          = var.nat_router_name
  network_name             = var.network_name
  region                   = var.region
  subnetwork_ip_cidr_range = var.subnetwork_ip_cidr_range
  subnetwork_name          = var.subnetwork_name
}