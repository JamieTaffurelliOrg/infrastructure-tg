terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-containerappenv-tf///?ref=0.0.13"
}

include {
  path = find_in_parent_folders()
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "5284e392-c44d-444a-bf2e-07452a860241"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azapi" {
  subscription_id = "5284e392-c44d-444a-bf2e-07452a860241"
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
    data-classification = "confidential"
    criticality         = "mission-critical"
    ops-commitment      = "workload-operations"
    ops-team            = "sre"
    cost-owner          = "jltaffurelli@outlook.com"
    owner               = "jltaffurelli@outlook.com"
    sla                 = "high"
    environment         = "dev"
    stack               = "app"
  }
}

inputs = {

  container_app_environment_name              = "cae-app-dev-cae-weu1-001"
  resource_group_name                         = "rg-app-dev-cae-weu1-001"
  location                                    = "westeurope"
  zone_redundant                              = false
  subnet_name                                 = "snet-cae"
  virtual_network_name                        = "vnet-app-dev-net-weu1-001"
  subnet_resource_group_name                  = "rg-app-dev-net-weu1-001"
  infrastructure_resource_group               = "cae-app-dev-cae-weu1-001-managed"
  maximum_count                               = 1
  minimum_count                               = 0
  log_analytics_workspace_name                = "log-mgmt-dev-log-weu1-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-dev-log-weu1-001"
  tags                                        = merge(local.tags, { workload = "container-app" })
}
