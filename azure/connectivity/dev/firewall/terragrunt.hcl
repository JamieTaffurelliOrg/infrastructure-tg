terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-firewall-tf///?ref=0.0.3"
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

  resource_group_name                         = "rg-conn-dev-hub-wus2-001"
  location                                    = "westus2"
  public_ip_name                              = "pip-conn-dev-afw-wus2-001"
  public_ip_prefix_name                       = "ippre-conn-dev-hub-wus2-001"
  public_ip_prefix_resource_group_name        = "rg-conn-dev-hub-wus2-001"
  firewall_name                               = "afw-conn-dev-afw-wus2-001"
  firewall_sku                                = "Standard"
  firewall_policy_name                        = "afwp-conn-dev-afwp-wus2-001"
  firewall_policy_resource_group_name         = "rg-conn-dev-afwp-wus2-001"
  virtual_network_name                        = "vnet-conn-dev-hub-wus2-001"
  zone_redundant                              = false
  log_analytics_workspace_name                = "log-mgmt-dev-log-wus2-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-dev-log-wus2-001"
  tags                                        = merge(local.tags, { workload-name = "firewall" })
}
