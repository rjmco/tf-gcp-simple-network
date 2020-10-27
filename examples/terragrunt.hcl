generate "providers" {
  path      = "tg_gen_providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = file("tg_files/providers.tf")
}

generate "versions" {
  path      = "tg_gen_versions.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_version = "~> 0.13.0"
}
EOF
}