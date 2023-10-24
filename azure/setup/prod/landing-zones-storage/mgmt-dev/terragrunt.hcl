terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-landingzone-storage-tf///?ref=0.0.28"
}

include "azure" {
  path = find_in_parent_folders("azure.hcl")
}

include "setup" {
  path = find_in_parent_folders("setup.hcl")
}

include "prod" {
  path = find_in_parent_folders("prod.hcl")
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "9661faf5-39f5-400b-931a-342f9240c71b"

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

  storage_account_name                = "stjtmgmtdevtfweu1001"
  location                            = "westeurope"
  resource_group_name                 = "rg-mgmt-dev-tf-weu1-001"
  network_watcher_resource_group_name = "rg-mgmt-dev-netwat-weu1-001"
  network_watchers = {
    west_europe = {
      name     = "nw-mgmt-dev-netwat-weu1-001"
      location = "westeurope"
    }
  }
  containers = ["mgmt-dev"]
  storage_account_network_rules = {
    default_action = "Allow"
  }
  log_analytics_workspace = {
    name                = "log-mgmt-dev-log-weu1-001"
    resource_group_name = "rg-mgmt-dev-log-weu1-001"
  }
  tags = merge(local.tags, { environment = "dev", stack = "management" })
}
