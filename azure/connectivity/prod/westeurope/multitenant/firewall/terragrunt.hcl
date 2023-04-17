terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-firewall-tf///?ref=0.0.4"
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
  subscription_id = "354a71d2-11ed-4c91-abb2-a08a2b4abe69"

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

  resource_group_name                         = "rg-conn-prod-hub-weu1-001"
  location                                    = "westeurope"
  public_ip_name                              = "pip-conn-prod-afw-weu1-001"
  public_ip_prefix_name                       = "ippre-conn-prod-hub-weu1-001"
  public_ip_prefix_resource_group_name        = "rg-conn-prod-hub-weu1-001"
  firewall_name                               = "afw-conn-prod-afw-weu1-001"
  firewall_sku                                = "Standard"
  firewall_policy_name                        = "afwp-conn-prod-afwp-weu1-001"
  firewall_policy_resource_group_name         = "rg-conn-prod-afwp-weu1-001"
  virtual_network_name                        = "vnet-conn-prod-hub-weu1-001"
  zone_redundant                              = true
  log_analytics_workspace_name                = "log-mgmt-prod-log-weu1-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-prod-log-weu1-001"
  tags                                        = merge(local.tags, { workload-name = "firewall" })
}
