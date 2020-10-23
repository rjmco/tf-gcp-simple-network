locals {
  google_providers_version = "3.44.0"
}

generate "providers" {
  path      = "tg_gen_providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "${local.google_providers_version}"
    }
  }
}
EOF
}

generate "uniq_id" {
  path      = "tg_gen_uniq_id.tf"
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
