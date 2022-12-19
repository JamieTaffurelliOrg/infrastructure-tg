terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-landingzone-storage-tf///?ref=0.0.6"
}

include {
  path = find_in_parent_folders()
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "34eba0af-b158-4f38-84c6-0f14cf06cfe1"

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

  storage_account_name = "stjtconnshrdtffrc1001"
  location             = "francecentral"
  resource_group_name  = "rg-conn-shrd-tf-frc1-001"
  containers           = ["conn-shrd"]
  storage_account_network_rules = {
    default_action = "Allow"
  }
  log_analytics_workspace = {
    name                = "log-mgmt-prod-log-wus1-001"
    resource_group_name = "rg-mgmt-prod-log-wus1-001"
  }
  tags = merge(local.tags, { environment = "shared", stack = "connectivity" })
}
