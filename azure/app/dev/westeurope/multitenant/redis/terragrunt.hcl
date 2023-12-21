terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-redis-tf///?ref=0.0.4"
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
  subscription_id = ${include.azure.locals.app_dev_subscription_id}

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
  subscription_id = ${include.azure.locals.mgmt_dev_subscription_id}

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "dns"
  subscription_id = ${include.azure.locals.conn_dev_subscription_id}

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
EOF

}

locals {
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { workload = "redis" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.landing_zone_name}-${include.environment.environment_name}"
  lz_environment_concat = "${include.landing_zone.landing_zone_name}${include.environment.environment_name}"
  location_short        = include.region.region_short
  location              = include.region.region_full
}

inputs = {

  resource_group_name = "rg-${local.lz_environment_hyphen}-redis-${local.location_short}-001"
  location            = local.location
  redis_cache_name    = "redis-${local.lz_environment_hyphen}-redis-${local.location_short}-001"
  capacity            = 0
  family              = "C"
  sku_name            = "Basic"
  day_of_week         = "Friday"
  start_hour_utc      = 23
  redis_firewall_rules = [
    {
      name     = "test"
      start_ip = "0.0.0.0"
      end_ip   = "255.255.255.255"
    }
  ]
  subnet_name                = "snet-redis"
  virtual_network_name       = "vnet-${local.lz_environment_hyphen}-net-${local.location_short}-001"
  subnet_resource_group_name = "rg-${local.lz_environment_hyphen}-net-${local.location_short}-001"
  private_dns_zones = [
    {
      name                = "privatelink.redis.cache.windows.net"
      resource_group_name = "rg-conn-dev-prvdns-${local.location_short}-001"
    }
  ]
  log_analytics_workspace_name                = "log-mgmt-${include.environment.environment_name}-log-${local.location_short}-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-${include.environment.environment_name}-log-${local.location_short}-001"
  tags                                        = local.tags
}
