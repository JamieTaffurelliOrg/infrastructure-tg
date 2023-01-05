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
  subscription_id = "58b4ad6f-a160-4b9e-841b-e177f66137c9"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
  subscription_id = "4593b317-03e9-4533-9f41-e0d4b6da338c"

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

  resource_group_name                         = "rg-conn-dev-bas-wus2-001"
  location                                    = "westus2"
  public_ip_name                              = "pip-conn-dev-bas-wus2-001"
  public_ip_prefix_name                       = "ippre-conn-dev-hub-wus2-001"
  public_ip_prefix_resource_group_name        = "rg-conn-dev-hub-wus2-001"
  bastion_host_name                           = "bas-conn-dev-bas-wus2-001"
  virtual_network_name                        = "vnet-conn-dev-hub-wus2-001"
  virtual_network_resource_group_name         = "rg-conn-dev-hub-wus2-001"
  log_analytics_workspace_name                = "log-mgmt-dev-log-wus2-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-dev-log-wus2-001"
  tags                                        = merge(local.tags, { workload-name = "bastion" })
}
