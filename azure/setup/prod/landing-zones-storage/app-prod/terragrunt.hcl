terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-landingzone-storage-tf///?ref=0.0.28"
}

include {
  path = find_in_parent_folders()
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
    workload            = "tfstate"
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

  storage_account_name                = "stjtappprodtfweu1001"
  location                            = "westeurope"
  resource_group_name                 = "rg-app-prod-tf-weu1-001"
  network_watcher_resource_group_name = "rg-app-prod-netwat-weu1-001"
  network_watchers = {
    west_europe = {
      name     = "nw-app-prod-netwat-weu1-001"
      location = "westeurope"
    }
  }
  containers = ["app-prod", "app-prod-kv"]
  storage_account_network_rules = {
    default_action = "Allow"
  }
  boot_diagnostic_storage_accounts = [
    {
      name                = "stjtappproddiagweu1002"
      location            = "westeurope"
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
