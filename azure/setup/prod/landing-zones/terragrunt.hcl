terraform {
  //source = "git::https://github.com/JamieTaffurelliOrg/az-landingzone-tf///?ref=0.0.2"
  source = "../../../../../az-landingzone-tf"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  billing_account_name                   = "724b0ab8-41a6-5f58-b060-4f73ec990bd2:d939fca2-f0a8-40ba-9337-1fd351effc0d_2019-05-31"
  billing_profile_name                   = "CKJO-5RHC-BG7-PGB"
  invoice_section_name                   = "OSSK-7NAT-PJA-PGB"
  org_management_group_name              = "jamietaffurelli"
  management_group_name_prefix           = "mg-jt"
  landing_zone_app_management_group_name = "app"
  policy_managed_identity_location       = "westeurope"
}
