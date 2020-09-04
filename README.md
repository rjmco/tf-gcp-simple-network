# tf-gcp-simple-network
Deploys a simple GCP VPC network.

This module was created with the purpose of testing terragrunt and testing
technologies and therefore it is very limited in functionality or flexibility.

It deploys the following resources into a given GCP project:
- 1x VPC network
- 1x subnetwork
- 1x Cloud NAT

## Usage

Refer to the examples under [examples/](examples)

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google | 3 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | Project ID where resources should be hosted on | `string` | n/a | yes |
| nat\_router\_name | Cloud NAT router name | `string` | `"nat-router"` | no |
| network\_name | VPC network name | `string` | `"network"` | no |
| region | Region where regional resources should be deployed on | `string` | `"europe-west2"` | no |
| subnetwork\_ip\_cidr\_range | Subnetwork IP CIDR range | `string` | `"192.168.0.0/24"` | no |
| subnetwork\_name | Subnetwork name | `string` | `"subnetwork"` | no |

## Outputs

| Name | Description |
|------|-------------|
| nat\_ips | List of external IP addresses allocated to the Cloud NAT instance |
| nat\_router\_name | Cloud NAT router's name |
| nat\_router\_self\_link | Cloud NAT router's selfLink |
| network\_name | VPC network name |
| network\_self\_link | VPC network selfLink |
| subnetwork\_name | Subnetwork's name |
| subnetwork\_self\_link | Subnetwork's selfLink |

