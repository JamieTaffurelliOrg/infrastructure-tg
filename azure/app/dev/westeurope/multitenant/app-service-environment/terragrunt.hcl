terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-ase-tf///?ref=0.0.7"
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
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { workload = "app-service" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.locals.landing_zone_name}-${include.environment.locals.environment_name}"
  lz_environment_concat = "${include.landing_zone.locals.landing_zone_name}${include.environment.locals.environment_name}"
  location_short        = include.region.locals.region_short
  location              = include.region.locals.region_full
}

inputs = {

  app_service_environment_name = "ase-${local.lz_environment_hyphen}-ase-${local.location_short}-001"
  resource_group_name          = "rg-${local.lz_environment_hyphen}-ase-${local.location_short}-001"
  location                     = local.location
  zone_redundant               = false
  subnet = {
    name                 = "snet-ase"
    virtual_network_name = "vnet-${local.lz_environment_hyphen}-net-${local.location_short}-001"
    resource_group_name  = "rg-${local.lz_environment_hyphen}-net-${local.location_short}-001"
  }
  service_plans = [
    {
      name                   = "asp-${local.lz_environment_hyphen}-ase-${local.location_short}-001"
      sku_name               = "I1v2"
      worker_count           = 1
      zone_balancing_enabled = true
    }
  ]
  log_analytics_workspace_name                = "log-mgmt-${include.environment.locals.environment_name}-log-${local.location_short}-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-${include.environment.locals.environment_name}-log-${local.location_short}-001"
  tags                                        = local.tags
}
