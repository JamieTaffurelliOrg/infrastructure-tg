terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-logging-tf///?ref=0.0.7"
}

remote_state {

  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    resource_group_name  = "rg-mgmt-prod-tf-weu1-001"
    storage_account_name = "stjtmgmtprodtfweu1001"
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
  subscription_id = "354a71d2-11ed-4c91-abb2-a08a2b4abe69"

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

  resource_group_name          = "rg-mgmt-prod-log-weu1-001"
  location                     = "westeurope"
  log_analytics_workspace_name = "log-mgmt-prod-log-weu1-001"
  automation_account_name      = "aa-mgmt-prod-log-weu1-001"
  storage_account_name         = "stjtmgmtprodlogweu1002"
  tags                         = merge(local.tags, { workload-name = "logging" })
}
