terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-storageaccount-tf///?ref=0.0.4"
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
  storage_use_azuread = true
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

provider "azurerm" {
  alias = "dns"
  subscription_id = "${include.azure.locals.conn_dev_subscription_id}"

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

  storage_account_name                   = "st${local.org_prefix}${local.lz_environment_concat}app${local.location_short}001"
  resource_group_name                    = "rg-${local.lz_environment_hyphen}-storage-${local.location_short}-001"
  location                               = local.location
  shared_access_key_enabled              = false
  account_replication_type               = "LRS"
  public_network_access_enabled          = true
  versioning_enabled                     = true
  change_feed_enabled                    = true
  change_feed_retention_in_days          = 30
  last_access_time_enabled               = true
  delete_retention_policy_days           = 30
  container_delete_retention_policy_days = 30
  containers                             = ["test"]
  storage_account_network_rules = {
    default_action = "Allow"
  }

  /*private_endpoints = [
    {
      name                            = "st${local.org_prefix}${local.lz_environment_concat}app${local.location_short}001-pe01"
      location                        = local.location
      subnet_id                       = string
      subresource_names               = list(string)
      private_service_connection_name = string
      private_dns_zone_ids            = list(string)
    }
  ]*/
  log_analytics_workspace_name                = "log-mgmt-${include.environment.locals.environment_name}-log-${local.location_short}-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-${include.environment.locals.environment_name}-log-${local.location_short}-001"
  tags                                        = local.tags
}
