terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-resourcegroup-tf///?ref=0.0.8"
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

  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "azurerm" {
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
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { environment = "dev", stack = "connectivity" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "conn-dev"
  lz_environment_concat = "conndev"
  location_short        = include.region.locals.region_short
  location              = include.region.locals.region_full
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
    },
    {
      name     = "rg-${local.lz_environment_hyphen}-vwan-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "hub" })
    },
    {
      name     = "rg-${local.lz_environment_hyphen}-vhub-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "hub" })
    },
    {
      name     = "rg-${local.lz_environment_hyphen}-dnspr-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "private-dns" })
    },
    {
      name     = "rg-${local.lz_environment_hyphen}-pip-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "hub" })
    }
  ]
}
