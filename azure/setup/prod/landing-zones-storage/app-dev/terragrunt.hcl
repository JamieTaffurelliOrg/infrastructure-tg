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
  subscription_id = "e1806152-a836-4eed-b591-d76f6267b6d2"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
  subscription_id = "4593b317-03e9-4533-9f41-e0d4b6da338c"

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

  storage_account_name                = "stjtappdevtffrc1001"
  location                            = "francecentral"
  resource_group_name                 = "rg-app-dev-tf-frc1-001"
  network_watcher_resource_group_name = "rg-app-dev-netwat-frc1-001"
  network_watchers = {
    west_us_2 = {
      name     = "nw-app-dev-netwat-wus2-001"
      location = "westus2"
    }
  }
  containers = ["app-dev", "app-dev-kv"]
  storage_account_network_rules = {
    default_action = "Allow"
  }
  boot_diagnostic_storage_accounts = [
    {
      name                = "stjtappdevdiagwus2001"
      location            = "westus2"
      resource_group_name = "rg-app-dev-diag-wus2-001"
      default_action      = "Allow"
    }
  ]
  log_analytics_workspace = {
    name                = "log-mgmt-dev-log-wus2-001"
    resource_group_name = "rg-mgmt-dev-log-wus2-001"
  }
  tags = merge(local.tags, { environment = "dev", stack = "app" })
}
