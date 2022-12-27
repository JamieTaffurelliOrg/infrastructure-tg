terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-logging-tf///?ref=0.0.6"
}

remote_state {

  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    resource_group_name  = "rg-mgmt-prod-tf-frc1-001"
    storage_account_name = "stjtmgmtprodtffrc1001"
    container_name       = "mgmt-prod"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    use_azuread_auth     = true
  }
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "510b35a4-6985-403e-939b-305da79e99bc"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
EOF

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
    stack               = "management"
  }
}

inputs = {

  resource_group_name          = "rg-mgmt-prod-log-wus2-001"
  location                     = "westus2"
  log_analytics_workspace_name = "log-mgmt-prod-log-wus2-001"
  automation_account_name      = "aa-mgmt-prod-log-wus-001"
  storage_account_name         = "stjtmgmtprodlogwus2001"
  network_watchers = {
    west_us = {
      name     = "nw-mgmt-prod-log-wus-001"
      location = "westus2"
    }
  }
  tags = merge(local.tags, { workload-name = "logging" })
}
