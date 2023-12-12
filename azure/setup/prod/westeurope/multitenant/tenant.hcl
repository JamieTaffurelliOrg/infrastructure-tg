locals {
  azure        = read_terragrunt_config(find_in_parent_folders("azure.hcl"))
  landing_zone = read_terragrunt_config(find_in_parent_folders("landing_zone.hcl"))
  environment  = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  region       = read_terragrunt_config(find_in_parent_folders("region.hcl"))
}

remote_state {

  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    resource_group_name  = "rg-${local.landing_zone.locals.landing_zone_name}-${local.environment.locals.environment_name}-tf-${local.landing_zone.locals.landing_zone_name}-${local.region.locals.region_short}-001"
    storage_account_name = "st${local.azure.locals.org_prefix}${local.landing_zone.locals.landing_zone_name}${local.environment.locals.environment_name}tf${local.region.locals.region_short}001"
    container_name       = "setup-${local.environment.locals.environment_name}"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    use_azuread_auth     = true
  }
}
