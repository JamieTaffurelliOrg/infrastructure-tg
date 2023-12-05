terraform {
  source = "git::https://github.com/aws-ia/terraform-aws-control_tower_account_factory///?ref=1.10.3"
}

include {
  path = find_in_parent_folders()
}

locals {
  tags = {
    data-classification = "confidential"
    criticality         = "mission-critical"
    ops-commitment      = "workload-operations"
    ops-team            = "sre"
    cost-owner          = "jltaffurelli@outlook.com"
    owner               = "jltaffurelli@outlook.com"
    sla                 = "high"
    environment         = "prod"
    stack               = "connectivity"
  }
}

inputs = {

  vcs_provider                                    = "github"
  account_customizations_repo_branch              = "main"
  account_customizations_repo_name                = "JamieTaffurelliOrg/aws-aft-customizations-tf"
  account_provisioning_customizations_repo_branch = "main"
  account_provisioning_customizations_repo_name   = "JamieTaffurelliOrg/aws-aft-provisioning-tf"
  account_request_repo_branch                     = "main"
  account_request_repo_name                       = "JamieTaffurelliOrg/aws-aft-requests-tf"
  aft_feature_cloudtrail_data_events              = true
  aft_feature_delete_default_vpcs_enabled         = true
  aft_vpc_endpoints                               = false
  aft_feature_enterprise_support                  = false
  aft_management_account_id                       = "333081807432"
  aft_metrics_reporting                           = true
  audit_account_id                                = "115165988639"
  cloudwatch_log_group_retention                  = "365"
  ct_home_region                                  = "eu-west-1"
  ct_management_account_id                        = "849872185050"
  global_customizations_repo_branch               = "main"
  global_customizations_repo_name                 = "JamieTaffurelliOrg/aws-aft-globalcustomizations-tf"
  log_archive_account_id                          = "454805729309"
  tf_backend_secondary_region                     = "eu-west-2"
}
