terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-landingzone-storage-tf///?ref=0.0.15"
}

include {
  path = find_in_parent_folders()
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "a9da0406-a642-49b3-9c2c-c8ed05bb1c85"

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

  storage_account_name                = "stjtmgmtshrdtffrc1001"
  location                            = "francecentral"
  resource_group_name                 = "rg-mgmt-shrd-tf-frc1-001"
  network_watcher_resource_group_name = "rg-mgmt-shrd-netwat-frc1-001"
  network_watchers = {
    west_us_2 = {
      name     = "nw-mgmt-shrd-netwat-wus2-001"
      location = "westus2"
    }
  }
  containers = ["mgmt-shrd"]
  storage_account_network_rules = {
    default_action = "Allow"
  }
  log_analytics_workspace = {
    name                = "log-mgmt-prod-log-wus2-001"
    resource_group_name = "rg-mgmt-prod-log-wus2-001"
  }
  tags = merge(local.tags, { environment = "shared", stack = "management" })
}
