terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-dnsresolver-tf///?ref=0.0.3"
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
  dns_resolver = {
    name                                     = "dnspr-conn-dev-dnspr-weu1-001"
    virtual_network_name                     = "vnet-conn-dev-dnspr-weu1-001"
    virtual_network_name_resource_group_name = "rg-conn-dev-dnspr-weu1-001"
    subnet_name                              = "snet-dnspr-001"
    inbound_endpoint_name                    = "in-001"
  }
  tags = merge(local.tags, { workload-name = "private-dns" })
}
