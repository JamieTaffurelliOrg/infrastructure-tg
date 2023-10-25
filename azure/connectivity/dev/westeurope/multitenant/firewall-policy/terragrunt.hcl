terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-firewallmanager-tf///?ref=0.0.12"
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

  resource_group_name = "rg-conn-dev-afwp-weu1-001"
  location            = "westeurope"
  ip_groups = [
    {
      name        = "ipgrp-conn-dev-afwp-weu1-001"
      cidr_ranges = ["10.128.0.0/9"]
    }
  ]
  base_policy_name = "afwp-conn-dev-afwp-weu1-001"
  base_policy_sku  = "Standard"
  base_policy_rule_collection_groups = [
    {
      name     = "afwp-conn-dev-afwp-weu1-001"
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
              source_ip_group_references = ["ipgrp-conn-dev-afwp-weu1-001"]
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
              source_ip_group_references = ["ipgrp-conn-dev-afwp-weu1-001"]
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
              source_ip_group_references = ["ipgrp-conn-dev-afwp-weu1-001"]
              destination_addresses      = ["0.0.0.0/0"]
              protocols                  = ["TCP"]
              destination_ports          = ["1-65535"]
            },
            {
              name                       = "udp-all"
              description                = "allow all"
              action                     = "Allow"
              source_ip_group_references = ["ipgrp-conn-dev-afwp-weu1-001"]
              destination_addresses      = ["0.0.0.0/0"]
              protocols                  = ["UDP"]
              destination_ports          = ["1-65535"]
            }
          ]
        }
      ]
    }
  ]
  child_policies = [
    {
      name = "afwp-conn-dev-afwp-weu1-002"
      dns = {
        proxy_enabled = true
        servers       = ["10.128.3.4"]
      }
    }
  ]
  log_analytics_workspace_name                = "log-mgmt-dev-log-weu1-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-dev-log-weu1-001"
  tags                                        = merge(local.tags, { workload = "firewall" })
}
