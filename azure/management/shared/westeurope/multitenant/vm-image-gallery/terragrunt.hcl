terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-vmimagegallery-tf///?ref=0.0.11"
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
  subscription_id = "${include.azure.locals.mgmt_shrd_subscription_id}"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
  storage_use_azuread = true
  subscription_id = "${include.azure.locals.mgmt_prod_subscription_id}"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
EOF

}

locals {
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { workload = "vm-images" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.locals.landing_zone_name}-${include.environment.locals.environment_name}"
  lz_environment_concat = "${include.landing_zone.locals.landing_zone_name}${include.environment.locals.environment_name}"
  location_short        = include.region.locals.region_short
  location              = include.region.locals.region_full
}

inputs = {

  resource_group_name       = "rg-${local.lz_environment_hyphen}-vmimg-${local.location_short}-001"
  location                  = local.location
  image_gallery_name        = "gal${local.lz_environment_concat}vmimg${local.location_short}001"
  image_gallery_description = "Store and share compliant VM images for deployment of VMs"
  images = [
    {
      name               = "win-2022-server-azure"
      os_type            = "Windows"
      description        = "Base windows 2022 server"
      publisher          = "MicrosoftWindowsServer"
      offer              = "WindowsServer"
      sku                = "2022-datacenter-azure-edition"
      hyper_v_generation = "V2"
    }
  ]
  storage_account_name = "st${local.org_prefix}${local.lz_environment_concat}vmimg${local.location_short}001"
  storage_account_network_rules = {
    default_action = "Allow"
  }
  log_analytics_workspace = {
    name                = "log-mgmt-prod-log-${local.location_short}-001"
    resource_group_name = "rg-mgmt-prod-log-${local.location_short}-001"
  }

  tags = local.tags
}
