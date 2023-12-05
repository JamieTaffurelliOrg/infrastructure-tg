terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-resourcegroup-tf///?ref=0.0.6"
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

  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "azurerm" {
  subscription_id = ${include.azure.locals.conn_prod_subscription_id}

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
EOF

}

locals {
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { environment = "conn", stack = "prod" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.landing_zone_name}-${include.environment.environment_name}"
  lz_environment_concat = "${include.landing_zone.landing_zone_name}${include.environment.environment_name}"
  location_short        = include.region.region_short
  location              = include.region.region_full
}

inputs = {

  resource_groups = [
    {
      name     = "rg-${local.lz_environment_hyphen}-hub-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "hub" })
    },
    {
      name     = "rg-${local.lz_environment_hyphen}-prvdns-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "private-dns" })
    },
    {
      name     = "rg-${local.lz_environment_hyphen}-bas-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "bastion" })
    },
    {
      name     = "rg-${local.lz_environment_hyphen}-afwp-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "firewall" })
    },
    {
      name     = "rg-${local.lz_environment_hyphen}-fdfp-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "front-door" })
    },
    {
      name     = "rg-${local.lz_environment_hyphen}-afd-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "front-door" })
    }
  ]
}
