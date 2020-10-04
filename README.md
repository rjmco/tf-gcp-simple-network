# tf-gcp-simple-network
Terraform module which deploys a simple GCP VPC network.

This module was created with the purpose of testing terragrunt and terragrunt
technologies and therefore it is very limited in functionality or flexibility.

It relies on Google Cloud Build to automate checks and tests both locally and
centrally in a Google Cloud Project. 

It deploys the following resources into a given GCP project:
- 1x VPC network
- 1x subnetwork
- 1x Cloud NAT

## Usage

Refer to the examples under [examples/](examples)

## Testing

Detailing how to test this module centrally on a Google Cloud Platform project
is outside the scope of this README.md file. Nonetheless, the
[cloudbuild.yaml](build/cloudbuild.yaml) file should be the same used on both
tests performed locally on the developer's wworkspace as well as the central
tests performed on a GCP project.

### Testing locally

#### Requirements

The following software needs to be installed on the developer's workstation:
- Docker Workstation
- Google Cloud SDK (aka `gcloud`)

To install Docker Workstation, please follow docker's official 
[documentation](https://docs.docker.com/get-docker/) or use your operating
system's package manager (such as `yum` for RH based linux distributions or
`brew` for macOS).

To install Google Cloud SDK, either use a package manager as referenced above
or follow Google's [documentation](https://cloud.google.com/sdk/docs/install)
on the subject. 

#### Setup Google Cloud SDK to run Cloud Build locally

The following instructions are based on
[this document](https://cloud.google.com/cloud-build/docs/build-debug-locally)
feel free to follow it for a more detailed understanding of the following steps.

1. install and configure the Docker credential helper for Cloud Build

```
gcloud components install docker-credential-gcr
gcloud auth configure-docker
```

2. Install Google Cloud Build's local builder:

```
gcloud components install cloud-build-local
```

#### Run the Cloud Build tests locally

1. Create a `local_env.sh` file with the following content (replace the values
accordingly):

```
export GOLANG_VERSION=<version>
export TERRAFORM_VERSION=<version>
export TERRAGRUNT_VERSION=<version>
```

2. Source the new variable file and execute the `scripts/local_test.bash` file:

```
source local_env.sh
./scripts/local_test.bash
```

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

