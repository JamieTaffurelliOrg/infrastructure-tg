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
  subscription_id = "${include.azure.locals.app_dev_subscription_id}"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
EOF

}

locals {
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { environment = "dev", stack = "app" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "app-dev"
  lz_environment_concat = "appdev"
  location_short        = include.region.locals.region_short
  location              = include.region.locals.region_full
}

inputs = {

  resource_groups = [
    {
      name     = "rg-${local.lz_environment_hyphen}-net-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "network" })
    },
    {
      name     = "rg-${local.lz_environment_hyphen}-lb-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "network" })
    },
    {
      name     = "rg-${local.lz_environment_hyphen}-web-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "web" })
    },
    {
      name     = "rg-${local.lz_environment_hyphen}-sql-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "sql" })
    },
    {
      name     = "rg-${local.lz_environment_hyphen}-kv-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "secrets" })
    },
    {
      name     = "rg-${local.lz_environment_hyphen}-redis-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "redis" })
    },
    {
      name     = "rg-${local.lz_environment_hyphen}-aci-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "containers" })
    },
    {
      name     = "rg-${local.lz_environment_hyphen}-ase-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "app-service" })
    },
    {
      name     = "rg-${local.lz_environment_hyphen}-agw-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "app-gateway" })
    },
    {
      name     = "rg-${local.lz_environment_hyphen}-cae-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "container-app" })
    },
    {
      name     = "rg-${local.lz_environment_hyphen}-ca-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "container-app" })
    },
    {
      name     = "rg-${local.lz_environment_hyphen}-pip-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "network" })
    },
    {
      name     = "rg-${local.lz_environment_hyphen}-waf-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "app-gateway" })
    },
    {
      name     = "rg-${local.lz_environment_hyphen}-cosmos-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "cosmosdb" })
    },
    {
      name     = "rg-${local.lz_environment_hyphen}-storage-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "storage" })
    },
    {
      name     = "rg-${local.lz_environment_hyphen}-sbus-${local.location_short}-001"
      location = local.location
      tags     = merge(local.tags, { workload = "servicebus" })
    }
  ]
}
