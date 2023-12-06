terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-vmimagetemplate-tf///?ref=0.0.7"
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
  ${include.azure.locals.mgmt_shrd_subscription_id}

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
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { workload = "vm-images" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.landing_zone_name}-${include.environment.environment_name}"
  lz_environment_concat = "${include.landing_zone.landing_zone_name}${include.environment.environment_name}"
  location_short        = include.region.region_short
  location              = include.region.region_full
}

inputs = {

  resource_group_name         = "rg-${local.lz_environment_hyphen}-vmimg-${local.location_short}-001"
  location                    = local.location
  user_assigned_identity_name = "gal${local.lz_environment_concat}vmimg${local.location_short}001"
  gallery_name                = "gal${local.lz_environment_concat}vmimg${local.location_short}001"
  windows_image_templates = [
    {
      name       = "win2022azimg"
      image_name = "win-2022-server-azure"
      artifact_tags = {
        "os" : "Windows",
        "version" : "2022",
        "flavour" : "Azure"
      }
      hardening_script_url = "https://st${local.org_prefix}${local.lz_environment_concat}vmimg${local.location_short}001.blob.core.windows.net/scripts/windows-server-hardening.ps1"
    }
  ]

  tags = local.tags
}
