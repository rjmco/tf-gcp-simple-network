generate "providers" {
  path      = "tg_gen_providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = file("tg_files/providers.tf")
}