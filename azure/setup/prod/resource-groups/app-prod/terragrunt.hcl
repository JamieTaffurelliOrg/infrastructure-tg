terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-resourcegroup-tf///?ref=0.0.6"
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

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "azurerm" {
  subscription_id = ${include.azure.locals.app_prod_subscription_id}

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
    environment         = "prod"
    stack               = "app"
  }
}

inputs = {

  resource_groups = [
    {
      name     = "rg-app-prod-net-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "network" })
    },
    {
      name     = "rg-app-prod-lb-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "network" })
    },
    {
      name     = "rg-app-prod-web-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "web" })
    },
    {
      name     = "rg-app-prod-sql-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "sql" })
    },
    {
      name     = "rg-app-prod-kv-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "secrets" })
    }
  ]
}
