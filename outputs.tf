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
