terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-logging-tf///?ref=0.0.12"
}

remote_state {

  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    resource_group_name  = "rg-mgmt-dev-tf-weu1-001"
    storage_account_name = "stjtmgmtdevtfweu1001"
    container_name       = "mgmt-dev"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    use_azuread_auth     = true
  }
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "9661faf5-39f5-400b-931a-342f9240c71b"

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
    environment         = "dev"
    stack               = "management"
  }
}

inputs = {

  resource_group_name          = "rg-mgmt-dev-log-weu1-001"
  location                     = "westeurope"
  log_analytics_workspace_name = "log-mgmt-dev-log-weu1-001"
  automation_account_name      = "aa-mgmt-dev-log-weu1-001"
  storage_account_name         = "stjtmgmtdevlogweu1002"
  app_insights = {
    name = "appi-mgmt-dev-log-weu1-001"
  }

  tags = merge(local.tags, { workload = "logging" })
}
