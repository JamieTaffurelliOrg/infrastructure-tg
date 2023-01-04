terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-resourcegroup-tf///?ref=0.0.3"
}

include {
  path = find_in_parent_folders()
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "9689d784-a98b-49f0-8601-43a18ce83ab4"

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
      name     = "rg-conn-prod-hub-wus2-001"
      location = "westus2"
      tags     = merge(local.tags, { workload-name = "hub" })
    },
    {
      name     = "rg-conn-prod-prvdns-wus2-001"
      location = "westus2"
      tags     = merge(local.tags, { workload-name = "private-dns" })
    },
    {
      name     = "rg-conn-prod-bas-wus2-001"
      location = "westus2"
      tags     = merge(local.tags, { workload-name = "bastion" })
    }
  ]
}
