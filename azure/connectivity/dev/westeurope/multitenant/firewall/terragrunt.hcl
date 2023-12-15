terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-firewall-tf///?ref=0.0.5"
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
  subscription_id = ${include.azure.locals.conn_dev_subscription_id}

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
EOF

}

locals {
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { workload = "firewall" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.landing_zone_name}-${include.environment.environment_name}"
  lz_environment_concat = "${include.landing_zone.landing_zone_name}${include.environment.environment_name}"
  location_short        = include.region.region_short
  location              = include.region.region_full
}

inputs = {

  resource_group_name                         = "rg-${local.lz_environment_hyphen}-hub-${local.location_short}-001"
  location                                    = local.location
  public_ip_name                              = "pip-${local.lz_environment_hyphen}-afw-${local.location_short}-001"
  public_ip_prefix_name                       = "ippre-${local.lz_environment_hyphen}-hub-${local.location_short}-001"
  public_ip_prefix_resource_group_name        = "rg-${local.lz_environment_hyphen}-hub-${local.location_short}-001"
  firewall_name                               = "afw-${local.lz_environment_hyphen}-afw-${local.location_short}-001"
  firewall_sku                                = "Standard"
  firewall_policy_name                        = "afwp-${local.lz_environment_hyphen}-afwp-${local.location_short}-001"
  firewall_policy_resource_group_name         = "rg-${local.lz_environment_hyphen}-afwp-${local.location_short}-001"
  virtual_network_name                        = "vnet-${local.lz_environment_hyphen}-hub-${local.location_short}-001"
  zone_redundant                              = false
  log_analytics_workspace_name                = "log-mgmt-${include.environment.environment_name}-log-${local.location_short}-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-${include.environment.environment_name}-log-${local.location_short}-001"
  tags                                        = local.tags
}
