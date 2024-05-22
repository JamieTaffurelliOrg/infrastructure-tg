terraform {
  #source = "git::https://github.com/JamieTaffurelliOrg/az-servicebus-tf///?ref=0.0.6"
  source = "../../../../../../../az-servicebus-tf"
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

  service_bus_name              = "sbns-${local.org_prefix}-${local.lz_environment_hyphen}-app-${local.location_short}-001"
  resource_group_name           = "rg-${local.lz_environment_hyphen}-sbus-${local.location_short}-001"
  location                      = local.location
  sku                           = "Standard"
  local_auth_enabled            = false
  public_network_access_enabled = false
  zone_redundant                = false
  network_rule_set = {
    default_action = "Allow"
  }
  servicebus_queues = [
    {
      name                                 = "test"
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = false
      enable_partitioning                  = true
    }
  ]
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
