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
  subscription_id = "3d6c3571-dbcd-47fa-a4f1-f2993adb6c90"

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
      name     = "rg-conn-dev-hub-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "hub" })
    },
    {
      name     = "rg-conn-dev-prvdns-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "private-dns" })
    },
    {
      name     = "rg-conn-dev-bas-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "bastion" })
    },
    {
      name     = "rg-conn-dev-afwp-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "firewall" })
    },
    {
      name     = "rg-conn-dev-fdfp-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "front-door" })
    },
    {
      name     = "rg-conn-dev-afd-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "front-door" })
    },
    {
      name     = "rg-conn-dev-vwan-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "hub" })
    },
    {
      name     = "rg-conn-dev-vhub-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "hub" })
    },
    {
      name     = "rg-conn-dev-dnspr-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "private-dns" })
    },
    {
      name     = "rg-conn-dev-pip-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "hub" })
    },
    {
      name     = "rg-conn-dev-waf-weu1-001"
      location = "westeurope"
      tags     = merge(local.tags, { workload = "hub" })
    }
  ]
}
