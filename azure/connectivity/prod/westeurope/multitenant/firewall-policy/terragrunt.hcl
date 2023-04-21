terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-firewallmanager-tf///?ref=0.0.7"
}

include {
  path = find_in_parent_folders()
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "5091f2ec-a527-4b51-8e63-9f5de65e3a66"

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

  resource_group_name = "rg-conn-prod-afwp-weu1-001"
  location            = "westeurope"
  ip_groups = [
    {
      name        = "ipgrp-conn-prod-afwp-weu1-001"
      cidr_ranges = ["10.0.0.0/9"]
    }
  ]
  base_policy_name = "afwp-conn-prod-afwp-weu1-001"
  base_policy_sku  = "Standard"
  base_policy_rule_collection_groups = [
    {
      name     = "afwp-conn-prod-afwp-weu1-001"
      priority = 800
      application_rule_collections = [
        {
          name        = "base-app"
          priority    = 800
          description = "allow all outbound"
          action      = "Allow"
          rules = [
            {
              name                       = "all"
              description                = "allow all outbound"
              source_ip_group_references = ["ipgrp-conn-prod-afwp-weu1-001"]
              destination_fqdns          = ["*.com", "*.net", "*.org"]
              protocols = {
                "http" = {
                  type = "Http"
                  port = 80
                }
                "https" = {
                  type = "Https"
                  port = 443
                }
              }
            },
            {
              name                       = "windowsupdate"
              description                = "allow all outbound"
              source_ip_group_references = ["ipgrp-conn-prod-afwp-weu1-001"]
              destination_fqdn_tags      = ["WindowsUpdate"]
              protocols = {
                "http" = {
                  type = "Http"
                  port = 80
                }
                "https" = {
                  type = "Https"
                  port = 443
                }
              }
            }
          ]
        }

      ]
      network_rule_collections = [
        {
          name     = "base-net"
          priority = 700
          action   = "Allow"
          rules = [
            {
              name                       = "tcp-all"
              description                = "allow all"
              action                     = "Allow"
              source_ip_group_references = ["ipgrp-conn-prod-afwp-weu1-001"]
              destination_addresses      = ["0.0.0.0/0"]
              protocols                  = ["TCP"]
              destination_ports          = ["1-65535"]
            },
            {
              name                       = "udp-all"
              description                = "allow all"
              action                     = "Allow"
              source_ip_group_references = ["ipgrp-conn-prod-afwp-weu1-001"]
              destination_addresses      = ["0.0.0.0/0"]
              protocols                  = ["UDP"]
              destination_ports          = ["1-65535"]
            }
          ]
        }
      ]
    }
  ]
  log_analytics_workspace_name                = "log-mgmt-prod-log-weu1-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-prod-log-weu1-001"
  tags                                        = merge(local.tags, { workload-name = "firewall" })
}
