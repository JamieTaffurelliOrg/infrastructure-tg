terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-keyvault-tf///?ref=0.0.9"
}

include "azure" {
  path   = find_in_parent_folders("azure.hcl")
  expose = true
}

include "landing_zone" {
  path   = find_in_parent_folders("landing_zone.hcl")
  expose = true
}

include "environment" {
  path   = find_in_parent_folders("environment.hcl")
  expose = true
}

include "region" {
  path   = find_in_parent_folders("region.hcl")
  expose = true
}

include "tenant" {
  path   = find_in_parent_folders("tenant.hcl")
  expose = true
}

remote_state {

  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    resource_group_name  = "rg-${include.landing_zone.locals.landing_zone_name}-${include.environment.locals.environment_name}-tf-${include.landing_zone.locals.landing_zone_name}-${include.region.locals.region_short}-001"
    storage_account_name = "st${include.azure.locals.org_prefix}${include.landing_zone.locals.landing_zone_name}${include.environment.locals.environment_name}tf${include.region.locals.region_short}001"
    container_name       = "${include.landing_zone.locals.landing_zone_name}-${include.environment.locals.environment_name}-kv"
    key                  = "${path_relative_to_include("tenant")}/terraform.tfstate"
    use_azuread_auth     = true
  }
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "${include.azure.locals.app_dev_subscription_id}"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
  subscription_id = "${include.azure.locals.mgmt_dev_subscription_id}"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
EOF

}

locals {
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { workload = "secrets" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.locals.landing_zone_name}-${include.environment.locals.environment_name}"
  lz_environment_concat = "${include.landing_zone.locals.landing_zone_name}${include.environment.locals.environment_name}"
  location_short        = include.region.locals.region_short
  location              = include.region.locals.region_full
}

inputs = {

  resource_group_name                         = "rg-${local.lz_environment_hyphen}-kv-${local.location_short}-001"
  location                                    = local.location
  key_vault_name                              = "kv-${local.lz_environment_hyphen}-kv-${local.location_short}-001"
  network_acl_bypass                          = "AzureServices"
  network_acl_default_action                  = "Allow"
  log_analytics_workspace_name                = "log-mgmt-${include.environment.locals.environment_name}-log-${local.location_short}-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-${include.environment.locals.environment_name}-log-${local.location_short}-001"
  tags                                        = local.tags
}
