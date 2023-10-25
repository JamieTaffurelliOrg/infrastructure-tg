terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-bastion-tf///?ref=0.0.8"
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

dependency "network" {
  config_path = "../network"

  mock_outputs = {
    subnets = {
      "AzureBastionSubnet" = {
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
  subscription_id = ${include.azure.locals.conn_dev_subscription_id}

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
  subscription_id = ${include.azure.locals.mgmt_dev_subscription_id}

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

  resource_group_name                         = "rg-conn-dev-bas-weu1-001"
  location                                    = "westeurope"
  public_ip_name                              = "pip-conn-dev-bas-weu1-001"
  public_ip_prefix_name                       = "ippre-conn-dev-pip-weu1-001"
  public_ip_prefix_resource_group_name        = "rg-conn-dev-pip-weu1-001"
  bastion_host_name                           = "bas-conn-dev-bas-weu1-001"
  sku                                         = "Standard"
  copy_paste_enabled                          = true
  file_copy_enabled                           = true
  tunneling_enabled                           = true
  subnet_id                                   = dependency.network.outputs.subnets["AzureBastionSubnet"].id
  log_analytics_workspace_name                = "log-mgmt-dev-log-weu1-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-dev-log-weu1-001"
  tags                                        = merge(local.tags, { workload = "bastion" })
}
