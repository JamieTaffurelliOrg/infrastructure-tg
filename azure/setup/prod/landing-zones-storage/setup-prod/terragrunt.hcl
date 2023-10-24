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
  subscription_id = "625faac3-7208-4816-8899-7e546d0e830b"

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

  storage_account_name                = "stjtstpprodtfweu1001"
  location                            = "westeurope"
  resource_group_name                 = "rg-stp-prod-tf-weu1-001"
  network_watcher_resource_group_name = "rg-stp-prod-netwat-weu1-001"
  network_watchers = {
    west_europe = {
      name     = "nw-stp-prod-netwat-weu1-001"
      location = "westeurope"
    }
  }
  containers = ["setup-prod"]
  storage_account_network_rules = {
    default_action = "Allow"
  }
  log_analytics_workspace = {
    name                = "log-mgmt-prod-log-weu1-001"
    resource_group_name = "rg-mgmt-prod-log-weu1-001"
  }
  tags = merge(local.tags, { environment = "prod", stack = "setup" })
}
