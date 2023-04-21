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
  subscription_id = "3d6c3571-dbcd-47fa-a4f1-f2993adb6c90"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
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

  storage_account_name                = "stjtconndevtfweu1001"
  location                            = "westeurope"
  resource_group_name                 = "rg-conn-dev-tf-weu1-001"
  network_watcher_resource_group_name = "rg-conn-dev-netwat-weu1-001"
  network_watchers = {
    west_europe = {
      name     = "nw-conn-dev-netwat-weu1-001"
      location = "westeurope"
    }
  }
  containers = ["conn-dev"]
  storage_account_network_rules = {
    default_action = "Allow"
  }
  log_analytics_workspace = {
    name                = "log-mgmt-dev-log-weu1-001"
    resource_group_name = "rg-mgmt-dev-log-weu1-001"
  }
  tags = merge(local.tags, { environment = "dev", stack = "connectivity" })
}
