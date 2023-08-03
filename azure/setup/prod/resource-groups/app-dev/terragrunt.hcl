terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-resourcegroup-tf///?ref=0.0.6"
}

include {
  path = find_in_parent_folders()
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "5284e392-c44d-444a-bf2e-07452a860241"

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
      tags     = merge(local.tags, { workload = "network" })
    },
    {
      name     = "rg-app-dev-lb-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "network" })
    },
    {
      name     = "rg-app-dev-web-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "web" })
    },
    {
      name     = "rg-app-dev-sql-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "sql" })
    },
    {
      name     = "rg-app-dev-kv-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "secrets" })
    },
    {
      name     = "rg-app-dev-redis-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "redis" })
    },
    {
      name     = "rg-app-dev-aci-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "containers" })
    },
    {
      name     = "rg-app-dev-ase-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "app-service" })
    },
    {
      name     = "rg-app-dev-agw-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "app-gateway" })
    },
    {
      name     = "rg-app-dev-cae-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "container-app" })
    },
    {
      name     = "rg-app-dev-ca-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "container-app" })
    }
  ]
}
