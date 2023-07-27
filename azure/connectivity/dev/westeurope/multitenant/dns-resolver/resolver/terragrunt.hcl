terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-dnsresolver-tf///?ref=0.0.4"
}

include {
  path = find_in_parent_folders()
}

dependency "network" {
  config_path = "../network"

  mock_outputs = {
    virtual_network_id = "tempvnetid"
    subnets = {
      "snet-dnspr-001" = {
        id = "tempid"
      }
    }
  }
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

provider "azurerm" {
  alias = "logs"
  subscription_id = "9661faf5-39f5-400b-931a-342f9240c71b"

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

  resource_group_name = "rg-conn-dev-dnspr-weu1-001"
  location            = "westeurope"
  dns_resolver_name   = "dnspr-conn-dev-dnspr-weu1-001"
  virtual_network_id  = dependency.network.outputs.virtual_network_id
  inbound_endpoints = [
    {
      inbound_endpoint_name = "in-001"
      subnet_id             = dependency.network.outputs.subnets["snet-dnspr-001"].id
    }
  ]
  tags = merge(local.tags, { workload = "private-dns" })
}
