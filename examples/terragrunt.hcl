generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.27.0"
    }
  }
}
EOF
}

generate "uniq_id" {
  path      = "uniq_id.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
resource "random_string" "uniq_id" {
  length = 6

  lower   = true
  number  = true
  special = false
  upper   = false
}
EOF
}
