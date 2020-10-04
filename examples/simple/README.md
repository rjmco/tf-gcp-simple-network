# `simple_example`

## Usage

To deploy this example, change directory into it and deploy using `terragrunt`
as shown below (replace `<PROJECT_ID>` with the project ID you want to deploy
the example on):

```shell script
export TF_VAR_project_id=<PROJECT_ID>
terragrunt apply -auto-approve
```

To destroy the created resources use `terragrunt` as shown below:

```shell script
terragrunt destroy -auto-approve
```

## Requirements

| Name | Version |
|------|---------|
| google | 3.27.0 |

## Providers

| Name | Version |
|------|---------|
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | Project ID where resources should be hosted on | `string` | n/a | yes |
| nat\_router\_name | Cloud NAT router name. If left empty it will default to `nat-router-<RANDOM>` | `string` | `""` | no |
| network\_name | VPC network name. If left empty it will default to `network-<RANDOM>` | `string` | `""` | no |
| region | Region where regional resources should be deployed on | `string` | `"europe-west2"` | no |
| subnetwork\_name | Subnetwork name. If left empty it will default to `subnetwork-<RANDOM>` | `string` | `""` | no |

## Outputs

No output.
