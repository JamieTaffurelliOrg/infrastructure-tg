terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-virtualhub-tf///?ref=0.0.13"
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
  subscription_id = "${include.azure.locals.conn_dev_subscription_id}"

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
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { workload = "hub" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.locals.landing_zone_name}-${include.environment.locals.environment_name}"
  lz_environment_concat = "${include.landing_zone.locals.landing_zone_name}${include.environment.locals.environment_name}"
  location_short        = include.region.locals.region_short
  location              = include.region.locals.region_full
}

inputs = {
  virtual_hub_name                = "vhub-${local.lz_environment_hyphen}-vhub-${local.location_short}-001"
  resource_group_name             = "rg-${local.lz_environment_hyphen}-vhub-${local.location_short}-001"
  location                        = local.location
  virtual_wan_name                = "vwan-${local.lz_environment_hyphen}-vwan-${local.location_short}-001"
  virtual_wan_resource_group_name = "rg-${local.lz_environment_hyphen}-vwan-${local.location_short}-001"
  address_prefix                  = "10.128.0.0/23"
  firewall = {
    name                       = "afw-${local.lz_environment_hyphen}-vhub-${local.location_short}-001"
    policy_name                = "afwp-${local.lz_environment_hyphen}-afwp-${local.location_short}-002"
    policy_resource_group_name = "rg-${local.lz_environment_hyphen}-afwp-${local.location_short}-001"
    zone_redundant             = false
    public_ip_count            = 1
  }
  log_analytics_workspace_name                = "log-mgmt-${include.environment.locals.environment_name}-log-${local.location_short}-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-${include.environment.locals.environment_name}-log-${local.location_short}-001"

  tags = local.tags
}
