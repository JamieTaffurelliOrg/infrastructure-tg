terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-landingzone-storage-tf///?ref=0.0.33"
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
  subscription_id = "${include.azure.locals.app_prod_subscription_id}"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
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
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { environment = "prod", stack = "app" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "app-prod"
  lz_environment_concat = "appprod"
  location_short        = include.region.locals.region_short
  location              = include.region.locals.region_full
}

inputs = {

  storage_account_name = "st${local.org_prefix}${local.lz_environment_concat}tf${local.location_short}001"
  location             = local.location
  resource_group_name  = "rg-${local.lz_environment_hyphen}-tf-${local.location_short}-001"
  network_watchers = {
    resource_group_name = "rg-${local.lz_environment_hyphen}-netwat-${local.location_short}-001"
    network_watchers = {
      west_europe = {
        name     = "nw-${local.lz_environment_hyphen}-netwat-${local.location_short}-001"
        location = local.location
      }
    }
    tags = merge(local.tags, { workload = "logs" })
  }
  containers = ["${local.lz_environment_hyphen}", "${local.lz_environment_hyphen}-kv"]
  storage_account_network_rules = {
    default_action = "Allow"
  }
  log_analytics_workspace = {
    name                = "log-mgmt-prod-log-${local.location_short}-001"
    resource_group_name = "rg-mgmt-prod-log-${local.location_short}-001"
  }

  tags = merge(local.tags, { workload = "tfstate" })
}
