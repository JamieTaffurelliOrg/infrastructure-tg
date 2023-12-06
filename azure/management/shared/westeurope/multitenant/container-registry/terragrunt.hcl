terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-acr-tf///?ref=0.0.7"
}

include "azure" {
  path = find_in_parent_folders("azure.hcl")
}

include "landing_zone" {
  path = find_in_parent_folders("landing_zone.hcl")
}

include "environment" {
  path = find_in_parent_folders("environment.hcl")
}

include "region" {
  path = find_in_parent_folders("region.hcl")
}

include "tenant" {
  path = find_in_parent_folders("tenant.hcl")
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azurerm" {
  ${include.azure.locals.mgmt_shrd_subscription_id}

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
  ${include.azure.locals.mgmt_prod_subscription_id}

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
EOF

}

locals {
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { workload = "container-images" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.landing_zone_name}-${include.environment.environment_name}"
  lz_environment_concat = "${include.landing_zone.landing_zone_name}${include.environment.environment_name}"
  location_short        = include.region.region_short
  location              = include.region.region_full
}

inputs = {

  resource_group_name                         = "rg-${local.lz_environment_hyphen}-acr-${local.location_short}-001"
  location                                    = local.location
  container_registry_name                     = "cr${local.lz_environment_concat}acr${local.location_short}001"
  sku                                         = "Basic"
  public_network_access_enabled               = true
  export_policy_enabled                       = true
  enable_retention_policy                     = false
  enable_trust_policy                         = false
  log_analytics_workspace_name                = "log-mgmt-prod-log-${local.location_short}-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-prod-log-${local.location_short}-001"

  tags = local.tags
}
