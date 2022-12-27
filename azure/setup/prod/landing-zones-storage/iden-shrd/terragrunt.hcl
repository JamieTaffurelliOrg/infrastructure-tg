terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-landingzone-storage-tf///?ref=0.0.10"
}

include {
  path = find_in_parent_folders()
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "dad37d44-b43c-4baf-8681-77016fb30901"

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

  storage_account_name                = "stjtidenshrdtffrc1001"
  location                            = "francecentral"
  resource_group_name                 = "rg-iden-shrd-tf-frc1-001"
  network_watcher_resource_group_name = "rg-app-prod-netwat-frc1-001"
  network_watchers = {
    west_us = {
      name                = "nw-mgmt-prod-log-wus-001"
      resource_group_name = "rg-app-prod-netwat-frc1-001"
      location            = "westus2"
    }
  }
  containers = ["iden-shrd"]
  storage_account_network_rules = {
    default_action = "Allow"
  }
  log_analytics_workspace = {
    name                = "log-mgmt-prod-log-wus2-001"
    resource_group_name = "rg-mgmt-prod-log-wus2-001"
  }
  tags = merge(local.tags, { environment = "shared", stack = "identity" })
}
