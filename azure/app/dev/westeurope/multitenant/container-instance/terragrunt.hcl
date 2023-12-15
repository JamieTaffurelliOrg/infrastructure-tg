terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-aci-tf///?ref=0.0.4"
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
EOF

}

locals {
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { workload = "web" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.locals.landing_zone_name}-${include.environment.locals.environment_name}"
  lz_environment_concat = "${include.landing_zone.locals.landing_zone_name}${include.environment.locals.environment_name}"
  location_short        = include.region.locals.region_short
  location              = include.region.locals.region_full
}

inputs = {

  container_group_name = "ci-${local.lz_environment_hyphen}-aci-${local.location_short}-001"
  resource_group_name  = "rg-${local.lz_environment_hyphen}-aci-${local.location_short}-001"
  location             = local.location
  os_type              = "Windows"
  ip_address_type      = "Private"
  containers = [
    {
      name   = "test"
      image  = "mcr.microsoft.com/windows/nanoserver:ltsc2022"
      cpu    = "0.5"
      memory = "1.5"
      ports = [
        {
          port = 80
        }
      ]
    }
  ]
  exposed_ports = [
    {
      port = 80
    }
  ]
  subnet_name                                 = "snet-aci"
  virtual_network_name                        = "vnet-${local.lz_environment_hyphen}-net-${local.location_short}-001"
  subnet_resource_group_name                  = "rg-${local.lz_environment_hyphen}-net-${local.location_short}-001"
  log_analytics_workspace_name                = "log-mgmt-${include.environment.environment_name}-log-${local.location_short}-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-${include.environment.environment_name}-log-${local.location_short}-001"
  tags                                        = local.tags
}
