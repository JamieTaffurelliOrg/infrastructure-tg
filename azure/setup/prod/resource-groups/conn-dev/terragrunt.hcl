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
  subscription_id = "58b4ad6f-a160-4b9e-841b-e177f66137c9"

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
    stack               = "connectivity"
  }
}

inputs = {

  resource_groups = [
    {
      name     = "rg-conn-dev-hub-wus2-001"
      location = "westus2"
      tags     = merge(local.tags, { workload-name = "hub" })
    },
    {
      name     = "rg-conn-dev-prvdns-wus2-001"
      location = "westus2"
      tags     = merge(local.tags, { workload-name = "private-dns" })
    },
    {
      name     = "rg-conn-dev-bas-wus2-001"
      location = "westus2"
      tags     = merge(local.tags, { workload-name = "bastion" })
    },
    {
      name     = "rg-conn-dev-afwp-wus2-001"
      location = "westus2"
      tags     = merge(local.tags, { workload-name = "firewall" })
    },
    {
      name     = "rg-conn-dev-fdfp-wus2-001"
      location = "westus2"
      tags     = merge(local.tags, { workload-name = "front-door" })
    }
  ]
}
