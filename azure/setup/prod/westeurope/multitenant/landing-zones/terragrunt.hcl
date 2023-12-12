terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-landingzone-tf///?ref=0.1.6"
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
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
EOF

}

locals {
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags)
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.locals.landing_zone_name}-${include.environment.locals.environment_name}"
  lz_environment_concat = "${include.landing_zone.locals.landing_zone_name}${include.environment.locals.environment_name}"
  location_short        = include.region.locals.region_short
  location              = include.region.locals.region_full
}

inputs = {
  billing_account_name         = "724b0ab8-41a6-5f58-b060-4f73ec990bd2:d939fca2-f0a8-40ba-9337-1fd351effc0d_2019-05-31"
  billing_profile_name         = "CKJO-5RHC-BG7-PGB"
  invoice_section_name         = "OSSK-7NAT-PJA-PGB"
  org_management_group_name    = "jamietaffurelli"
  management_group_name_prefix = "mg-${local.org_prefix}"
  landing_zones = [
    {
      name          = "app"
      subscriptions = []
      management_groups = [
        {
          name          = "dev"
          subscriptions = ["app-dev"]
        },
        {
          name          = "prod"
          subscriptions = ["app-prod"]
        },
        {
          name          = "shared"
          subscriptions = ["app-shared"]
      }]
    }
  ]
  policy_managed_identity_location = local.location
}
