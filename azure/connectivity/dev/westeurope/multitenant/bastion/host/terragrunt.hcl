terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-bastion-tf///?ref=0.0.6"
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

  resource_group_name                         = "rg-conn-dev-bas-weu1-001"
  location                                    = "westeurope"
  public_ip_name                              = "pip-conn-dev-bas-weu1-001"
  public_ip_prefix_name                       = "ippre-conn-dev-hub-weu1-001"
  public_ip_prefix_resource_group_name        = "rg-conn-dev-hub-weu1-001"
  bastion_host_name                           = "bas-conn-dev-bas-weu1-001"
  sku                                         = "Standard"
  copy_paste_enabled                          = true
  file_copy_enabled                           = true
  tunneling_enabled                           = true
  virtual_network_name                        = "vnet-conn-dev-bas-weu1-001"
  virtual_network_resource_group_name         = "rg-conn-dev-hub-weu1-001"
  log_analytics_workspace_name                = "log-mgmt-dev-log-weu1-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-dev-log-weu1-001"
  tags                                        = merge(local.tags, { workload = "bastion" })
}