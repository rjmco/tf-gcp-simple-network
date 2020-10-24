# Examples

## Usage

To deploy any of the examples, change directory into one of them and deploy it
using `terragrunt` as shown below (replace `<PROJECT_ID>` with the project ID
you want to deploy the example on):

```shell script
export TF_VAR_project_id=<PROJECT_ID>
cd <example_directory>
terragrunt apply -auto-approve
```

To destroy the created resources use `terragrunt` as shown below:

```shell script
terragrunt destroy -auto-approve
```