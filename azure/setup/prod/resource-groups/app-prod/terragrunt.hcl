terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-resourcegroup-tf///?ref=0.0.5"
}

include {
  path = find_in_parent_folders()
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "f4722c2d-47d5-4513-a562-80465e3ee813"

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
      tags     = merge(local.tags, { workload-name = "network" })
    },
    {
      name     = "rg-app-prod-lb-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload-name = "network" })
    },
    {
      name     = "rg-app-prod-web-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload-name = "web" })
    },
    {
      name     = "rg-app-prod-sql-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload-name = "sql" })
    },
    {
      name     = "rg-app-prod-kv-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload-name = "secrets" })
    }
  ]
}
