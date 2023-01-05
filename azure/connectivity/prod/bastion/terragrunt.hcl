terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-bastion-tf///?ref=0.0.4"
}

include {
  path = find_in_parent_folders()
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "9689d784-a98b-49f0-8601-43a18ce83ab4"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
  subscription_id = "510b35a4-6985-403e-939b-305da79e99bc"

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
    environment         = "prod"
    stack               = "connectivity"
  }
}

inputs = {

  resource_group_name                         = "rg-conn-prod-bas-wus2-001"
  location                                    = "westus2"
  public_ip_name                              = "pip-conn-prod-bas-wus2-001"
  public_ip_prefix_name                       = "ippre-conn-prod-hub-wus2-001"
  public_ip_prefix_resource_group_name        = "rg-conn-prod-hub-wus2-001"
  bastion_host_name                           = "bas-conn-prod-bas-wus2-001"
  virtual_network_name                        = "vnet-conn-prod-hub-wus2-001"
  virtual_network_resource_group_name         = "rg-conn-prod-hub-wus2-001"
  log_analytics_workspace_name                = "log-mgmt-prod-log-wus2-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-prod-log-wus2-001"
  tags                                        = merge(local.tags, { workload-name = "bastion" })
}
