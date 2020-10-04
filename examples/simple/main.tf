module "simple_network" {
  source     = "../../"
  project_id = var.project_id

  nat_router_name = var.nat_router_name != "" ? var.nat_router_name : format("nat-router-%s", random_string.uniq_id.result)
  network_name    = var.network_name != "" ? var.network_name : format("network-%s", random_string.uniq_id.result)
  region          = var.region
  subnetwork_name = var.subnetwork_name != "" ? var.subnetwork_name : format("subnetwork-%s", random_string.uniq_id.result)
}