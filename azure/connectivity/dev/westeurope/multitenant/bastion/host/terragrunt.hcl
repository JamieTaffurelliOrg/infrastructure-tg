terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-bastion-tf///?ref=0.0.8"
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

dependency "network" {
  config_path = "../network"

  mock_outputs = {
    subnets = {
      "AzureBastionSubnet" = {
        id = "tempid"
      }
    }
  }
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
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { workload = "bastion" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.landing_zone_name}-${include.environment.environment_name}"
  lz_environment_concat = "${include.landing_zone.landing_zone_name}${include.environment.environment_name}"
  location_short        = include.region.region_short
  location              = include.region.region_full
}

inputs = {

  resource_group_name                         = "rg-${local.lz_environment_hyphen}-bas-${local.location_short}-001"
  location                                    = local.location
  public_ip_name                              = "pip-${local.lz_environment_hyphen}-bas-${local.location_short}-001"
  public_ip_prefix_name                       = "ippre-${local.lz_environment_hyphen}-pip-${local.location_short}-001"
  public_ip_prefix_resource_group_name        = "rg-${local.lz_environment_hyphen}-pip-${local.location_short}-001"
  bastion_host_name                           = "bas-${local.lz_environment_hyphen}-bas-${local.location_short}-001"
  sku                                         = "Standard"
  copy_paste_enabled                          = true
  file_copy_enabled                           = true
  tunneling_enabled                           = true
  subnet_id                                   = dependency.network.outputs.subnets["AzureBastionSubnet"].id
  log_analytics_workspace_name                = "log-mgmt-${include.environment.environment_name}-log-${local.location_short}-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-${include.environment.environment_name}-log-${local.location_short}-001"
  tags                                        = local.tags
}
