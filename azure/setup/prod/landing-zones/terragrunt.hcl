terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-landingzone-tf///?ref=0.0.2"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  billing_account_name                   = "8c477dca-75ed-5095-be10-5f47b41c1823:ed9161c5-9d59-4efd-a277-7b5a20fbcdb3_2019-05-31"
  billing_profile_name                   = "DUTF-CRTP-BG7-PGB"
  invoice_section_name                   = "UMR6-I5A5-PJA-PGB"
  org_management_group_name              = "jamietaffurelli"
  management_group_name_prefix           = "mg-jt"
  landing_zone_app_management_group_name = "app"
  policy_managed_identity_location       = "eastus2"
}
