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
  ${include.azure.locals.mgmt_shrd_subscription_id}

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

  resource_groups = [
    {
      name     = "rg-mgmt-shrd-vmimg-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "vm-images" })
    },
    {
      name     = "rg-mgmt-shrd-acr-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "container-images" })
    }
  ]
}
