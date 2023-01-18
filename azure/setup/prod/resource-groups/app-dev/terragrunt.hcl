terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-resourcegroup-tf///?ref=0.0.4"
}

include {
  path = find_in_parent_folders()
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "e1806152-a836-4eed-b591-d76f6267b6d2"

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

  resource_groups = [
    {
      name     = "rg-app-dev-net-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload-name = "network" })
    },
    {
      name     = "rg-app-dev-lb-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload-name = "network" })
    },
    {
      name     = "rg-app-dev-web-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload-name = "web" })
    },
    {
      name     = "rg-app-dev-sql-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload-name = "sql" })
    },
    {
      name     = "rg-app-dev-kv-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload-name = "secrets" })
    }
  ]
}
