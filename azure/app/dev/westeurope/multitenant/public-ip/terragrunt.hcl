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
  resource_group_name = "rg-app-dev-pip-weu1-001"
  location            = "westeurope"
  public_ip_prefixes = [
    {
      name          = "ippre-app-dev-pip-weu1-001"
      prefix_length = 31
    }
  ]

  tags = merge(local.tags, { workload = "network" })
}
