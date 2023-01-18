terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-landingzone-storage-tf///?ref=0.0.23"
}

include {
  path = find_in_parent_folders()
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
    workload-name       = "tfstate"
    data-classification = "confidential"
    criticality         = "mission-critical"
    ops-commitment      = "workload-operations"
    ops-team            = "sre"
    cost-owner          = "jltaffurelli@outlook.com"
    owner               = "jltaffurelli@outlook.com"
    sla                 = "high"
  }
}

inputs = {

  storage_account_name                = "stjtappprodtffrc1001"
  location                            = "francecentral"
  resource_group_name                 = "rg-app-prod-tf-frc1-001"
  network_watcher_resource_group_name = "rg-app-prod-netwat-frc1-001"
  network_watchers = {
    west_us_2 = {
      name     = "nw-app-prod-netwat-weu1-001"
      location = "westus2"
    }
  }
  containers = ["app-prod", "app-prod-kv"]
  storage_account_network_rules = {
    default_action = "Allow"
  }
  boot_diagnostic_storage_accounts = [
    {
      name                = "stjtappproddiagweu1001"
      location            = "westus2"
      resource_group_name = "rg-app-prod-diag-weu1-001"
      default_action      = "Allow"
    }
  ]
  log_analytics_workspace = {
    name                = "log-mgmt-prod-log-weu1-001"
    resource_group_name = "rg-mgmt-prod-log-weu1-001"
  }
  tags = merge(local.tags, { environment = "prod", stack = "app" })
}
