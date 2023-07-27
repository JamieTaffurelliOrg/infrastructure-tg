terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-publicip-tf///?ref=0.0.2"
}

include {
  path = find_in_parent_folders()
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

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
  resource_group_name = "rg-conn-dev-pip-weu1-001"
  location            = "westeurope"
  public_ip_prefixes = [
    {
      name          = "ippre-conn-dev-hub-weu1-001"
      prefix_length = 31
    }
  ]

  tags = merge(local.tags, { workload = "hub" })
}