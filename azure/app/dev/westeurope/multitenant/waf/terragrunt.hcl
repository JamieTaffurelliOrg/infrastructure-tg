terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-waf-tf///?ref=0.0.6"
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
  subscription_id = ${include.azure.locals.app_dev_subscription_id}

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
EOF

}

locals {
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { workload = "waf" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.landing_zone_name}-${include.environment.environment_name}"
  lz_environment_concat = "${include.landing_zone.landing_zone_name}${include.environment.environment_name}"
  location_short        = include.region.region_short
  location              = include.region.region_full
}

inputs = {

  resource_group_name = "rg-${local.lz_environment_hyphen}-waf-${local.location_short}-001"
  waf_policy_name     = "waf${local.lz_environment_concat}waf${local.location_short}001"
  location            = local.location
  mode                = "Detection"
  managed_rules = {
    managed_rule_sets = [
      {
        name    = "owasp-ruleset"
        type    = "OWASP"
        version = "3.2"
      }
    ]
  }
  tags = local.tags
}
