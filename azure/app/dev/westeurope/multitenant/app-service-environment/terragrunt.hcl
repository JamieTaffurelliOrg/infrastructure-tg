terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-ase-tf///?ref=0.0.3"
}

include "azure" {
  path = find_in_parent_folders("azure.hcl")
}

include "app" {
  path = find_in_parent_folders("app.hcl")
}

include "dev" {
  path = find_in_parent_folders("dev.hcl")
}

include "westeurope" {
  path = find_in_parent_folders("westeurope.hcl")
}

include "multitenant" {
  path = find_in_parent_folders("multitenant.hcl")
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

  app_service_environment_name = "ase-app-dev-ase-weu1-001"
  resource_group_name          = "rg-app-dev-ase-weu1-001"
  location                     = "westeurope"
  zone_redundant               = false
  subnet = {
    name                 = "snet-ase"
    virtual_network_name = "vnet-app-dev-net-weu1-001"
    resource_group_name  = "rg-app-dev-net-weu1-001"
  }
  service_plans = [
    {
      name                   = "asp-app-dev-ase-weu1-001"
      sku_name               = "I1v2"
      worker_count           = 1
      zone_balancing_enabled = true
    }
  ]
  log_analytics_workspace_name                = "log-mgmt-dev-log-weu1-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-dev-log-weu1-001"
  tags                                        = merge(local.tags, { workload = "app-service" })
}
