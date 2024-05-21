terraform {
  #source = "git::https://github.com/JamieTaffurelliOrg/az-cosmosdb-tf///?ref=0.0.5"
  source = "../../../../../../../az-cosmosdb-tf"
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
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { workload = "container-app" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.locals.landing_zone_name}-${include.environment.locals.environment_name}"
  lz_environment_concat = "${include.landing_zone.locals.landing_zone_name}${include.environment.locals.environment_name}"
  location_short        = include.region.locals.region_short
  location              = include.region.locals.region_full
}

inputs = {

  cosmosdb_account_name                 = "cosmos-${local.lz_environment_hyphen}-cosmos-${local.location_short}-001"
  resource_group_name                   = "rg-${local.lz_environment_hyphen}-cosmos-${local.location_short}-001"
  location                              = local.location
  analytical_storage_enabled            = true
  multiple_write_locations_enabled      = false
  access_key_metadata_writes_enabled    = false
  network_acl_bypass_for_azure_services = false
  local_authentication_disabled         = true
  capabilities                          = ["EnableServerless"]
  total_throughput_limit                = 4000
  consistency_policy = {
    consistency_policy = "Session"
  }
  geo_locations = [
    {
      location          = local.location
      failover_priority = 0
      zone_redundant    = false
    }
  ]
  backup = {
    type = "Continuous"
    tier = "Continuous7Days"
  }
  sql_databases = [
    {
      name = "testdb"
    }
  ]
  log_analytics_workspace_name                = "log-mgmt-${include.environment.locals.environment_name}-log-${local.location_short}-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-${include.environment.locals.environment_name}-log-${local.location_short}-001"
  tags                                        = local.tags
}
