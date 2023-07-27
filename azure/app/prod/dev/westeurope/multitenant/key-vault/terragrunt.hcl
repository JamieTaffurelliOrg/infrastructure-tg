terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-keyvault-tf///?ref=0.0.4"
}

remote_state {

  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    resource_group_name  = "rg-app-prod-tf-weu1-001"
    storage_account_name = "stjtappprodtfweu1001"
    container_name       = "app-prod-kv"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    use_azuread_auth     = true
  }
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "f4722c2d-47d5-4513-a562-80465e3ee813"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
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
    stack               = "app"
  }
}

inputs = {

  resource_group_name                         = "rg-app-prod-kv-weu1-001"
  location                                    = "westeurope"
  key_vault_name                              = "kv-app-prod-kv-weu1-001"
  network_acl_bypass                          = "AzureServices"
  network_acl_default_action                  = "Allow"
  log_analytics_workspace_name                = "log-mgmt-prod-log-weu1-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-prod-log-weu1-001"
  tags                                        = merge(local.tags, { workload = "secrets" })
}
