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
  ${include.azure.locals.mgmt_shrd_subscription_id}

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
  ${include.azure.locals.mgmt_prod_subscription_id}

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
