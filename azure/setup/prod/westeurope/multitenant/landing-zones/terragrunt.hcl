terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-landingzone-tf///?ref=0.0.4"
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

locals {
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { workload = "vm-images" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.landing_zone_name}-${include.environment.environment_name}"
  lz_environment_concat = "${include.landing_zone.landing_zone_name}${include.environment.environment_name}"
  location_short        = include.region.region_short
  location              = include.region.region_full
}

inputs = {
  billing_account_name                   = "724b0ab8-41a6-5f58-b060-4f73ec990bd2:d939fca2-f0a8-40ba-9337-1fd351effc0d_2019-05-31"
  billing_profile_name                   = "CKJO-5RHC-BG7-PGB"
  invoice_section_name                   = "OSSK-7NAT-PJA-PGB"
  org_management_group_name              = "jamietaffurelli"
  management_group_name_prefix           = "mg-${local.org_prefix}"
  landing_zone_app_management_group_name = "app"
  policy_managed_identity_location       = local.location
}
