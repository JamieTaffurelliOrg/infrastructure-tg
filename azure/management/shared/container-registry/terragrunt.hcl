terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-acr-tf///?ref=0.0.7"
}

include "azure" {
  path = find_in_parent_folders("azure.hcl")
}

include "landing_zone" {
  path = find_in_parent_folders("landing_zone.hcl")
}

include "shared" {
  path = find_in_parent_folders("shared.hcl")
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "3bdf403f-77ac-4879-8fba-fa41c2cc94ee"

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
    data-classification = "confidential"
    criticality         = "mission-critical"
    ops-commitment      = "workload-operations"
    ops-team            = "sre"
    cost-owner          = "jltaffurelli@outlook.com"
    owner               = "jltaffurelli@outlook.com"
    sla                 = "high"
    environment         = "shared"
    stack               = "management"
  }
}

inputs = {

  resource_group_name                         = "rg-mgmt-shrd-acr-weu1-001"
  location                                    = "westeurope"
  container_registry_name                     = "crmgmtshrdacrweu1001"
  sku                                         = "Basic"
  public_network_access_enabled               = true
  export_policy_enabled                       = true
  enable_retention_policy                     = false
  enable_trust_policy                         = false
  log_analytics_workspace_name                = "log-mgmt-prod-log-weu1-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-prod-log-weu1-001"

  tags = merge(local.tags, { workload = "container-images" })
}
