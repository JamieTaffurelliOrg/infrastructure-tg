terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-landingzone-storage-tf///?ref=0.0.28"
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
  subscription_id = ${include.azure.locals.app_shrd_subscription_id}

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
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { workload = "logs", environment = "shared", stack = "app" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.landing_zone_name}-${include.environment.environment_name}"
  lz_environment_concat = "${include.landing_zone.landing_zone_name}${include.environment.environment_name}"
  location_short        = include.region.region_short
  location              = include.region.region_full
}

inputs = {

  storage_account_name                = "st${local.org_prefix}appshrdtf${local.location_short}001"
  location                            = local.location
  resource_group_name                 = "rg-${local.lz_environment_hyphen}-tf-${local.location_short}-001"
  network_watcher_resource_group_name = "rg-${local.lz_environment_hyphen}-netwat-${local.location_short}-001"
  network_watchers = {
    west_europe = {
      name     = "nw-${local.lz_environment_hyphen}-netwat-${local.location_short}-001"
      location = local.location
    }
  }
  containers = ["${local.lz_environment_hyphen}"]
  storage_account_network_rules = {
    default_action = "Allow"
  }
  log_analytics_workspace = {
    name                = "log-mgmt-prod-log-${local.location_short}-001"
    resource_group_name = "rg-mgmt-prod-log-${local.location_short}-001"
  }
  tags = local.tags
}
