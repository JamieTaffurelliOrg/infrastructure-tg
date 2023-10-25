terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-virtualhub-tf///?ref=0.0.10"
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

include "westeurope" {
  path = find_in_parent_folders("region.hcl")
}

include "tenant" {
  path = find_in_parent_folders("tenant.hcl")
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
  virtual_hub_name                = "vhub-conn-dev-vhub-weu1-001"
  resource_group_name             = "rg-conn-dev-vhub-weu1-001"
  location                        = "westeurope"
  virtual_wan_name                = "vwan-conn-dev-vwan-weu1-001"
  virtual_wan_resource_group_name = "rg-conn-dev-vwan-weu1-001"
  address_prefix                  = "10.128.0.0/23"
  firewall = {
    name                       = "afw-conn-dev-vhub-weu1-001"
    policy_name                = "afwp-conn-dev-afwp-weu1-002"
    policy_resource_group_name = "rg-conn-dev-afwp-weu1-001"
    zone_redundant             = false
    public_ip_count            = 1
  }
  log_analytics_workspace_name                = "log-mgmt-dev-log-weu1-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-dev-log-weu1-001"

  tags = merge(local.tags, { workload = "hub" })
}
