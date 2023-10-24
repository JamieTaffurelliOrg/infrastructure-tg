terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-dnsresolver-tf///?ref=0.0.5"
}

include "azure" {
  path = find_in_parent_folders("azure.hcl")
}

include "connectivity" {
  path = find_in_parent_folders("connectivity.hcl")
}

include "dev" {
  path = find_in_parent_folders("dev.hcl")
}

include "westeurope" {
  path = find_in_parent_folders("westeurope.hcl")
}

include "multitenant" {
  path = find_in_parent_folders("multitenant.hcl")
}

dependency "network" {
  config_path = "../network"

  mock_outputs = {
    virtual_network_id = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/virtualNetworksValue"
    subnets = {
      "snet-dnspr-001" = {
        id = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/virtualNetworksValue/subnets/subnetValue"
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
      name      = "in-001"
      subnet_id = dependency.network.outputs.subnets["snet-dnspr-001"].id
    }
  ]
  tags = merge(local.tags, { workload = "private-dns" })
}
