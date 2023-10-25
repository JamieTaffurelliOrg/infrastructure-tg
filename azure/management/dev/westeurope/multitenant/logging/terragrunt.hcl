terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-logging-tf///?ref=0.0.13"
}

include "azure" {
  path = find_in_parent_folders("azure.hcl")
}

include "landing_zone" {
  path = find_in_parent_folders("landing_zone.hcl")
}

include "environment" {
  path = find_in_parent_folders("environment.hcl")
}

include "westeurope" {
  path = find_in_parent_folders("region.hcl")
}

include "tenant" {
  path = find_in_parent_folders("tenant.hcl")
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "azurerm" {
  subscription_id = ${include.azure.locals.mgmt_dev_subscription_id}

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
    stack               = "management"
  }
}

inputs = {

  resource_group_name          = "rg-mgmt-dev-log-weu1-001"
  location                     = "westeurope"
  log_analytics_workspace_name = "log-mgmt-dev-log-weu1-001"
  automation_account_name      = "aa-mgmt-dev-log-weu1-001"
  storage_account_name         = "stjtmgmtdevlogweu1002"
  app_insights = {
    name = "appi-mgmt-dev-log-weu1-001"
  }

  tags = merge(local.tags, { workload = "logging" })
}
