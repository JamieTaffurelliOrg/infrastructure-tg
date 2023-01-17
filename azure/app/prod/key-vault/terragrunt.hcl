terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-keyvault-tf///?ref=0.0.3"
}

remote_state {

  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    resource_group_name  = "rg-app-prod-tf-frc1-001"
    storage_account_name = "stjtappprodtffrc1001"
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
  subscription_id = "018499bc-61fd-4799-8107-d4ff6616527e"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
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
    stack               = "app"
  }
}

inputs = {

  resource_group_name                         = "rg-app-prod-kv-wus2-001"
  location                                    = "westus2"
  key_vault_name                              = "kv-app-prod-net-wus2-001"
  network_acl_default_action                  = "Allow"
  log_analytics_workspace_name                = "log-mgmt-prod-log-wus2-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-prod-log-wus2-001"
  tags                                        = merge(local.tags, { workload-name = "secrets" })
}
