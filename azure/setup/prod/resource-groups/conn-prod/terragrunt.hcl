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
  subscription_id = "5091f2ec-a527-4b51-8e63-9f5de65e3a66"

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
    stack               = "connectivity"
  }
}

inputs = {

  resource_groups = [
    {
      name     = "rg-conn-prod-hub-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "hub" })
    },
    {
      name     = "rg-conn-prod-prvdns-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "private-dns" })
    },
    {
      name     = "rg-conn-prod-bas-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "bastion" })
    },
    {
      name     = "rg-conn-prod-afwp-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "firewall" })
    },
    {
      name     = "rg-conn-prod-fdfp-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "front-door" })
    },
    {
      name     = "rg-conn-prod-afd-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "front-door" })
    }
  ]
}
