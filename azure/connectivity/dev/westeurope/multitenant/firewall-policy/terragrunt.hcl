terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-firewallmanager-tf///?ref=0.0.12"
}

include "azure" {
  path   = find_in_parent_folders("azure.hcl")
  expose = true
}

include "landing_zone" {
  path   = find_in_parent_folders("landing_zone.hcl")
  expose = true
}

include "environment" {
  path   = find_in_parent_folders("environment.hcl")
  expose = true
}

include "region" {
  path   = find_in_parent_folders("region.hcl")
  expose = true
}

include "tenant" {
  path   = find_in_parent_folders("tenant.hcl")
  expose = true
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
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { workload = "firewall" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.locals.landing_zone_name}-${include.environment.locals.environment_name}"
  lz_environment_concat = "${include.landing_zone.locals.landing_zone_name}${include.environment.locals.environment_name}"
  location_short        = include.region.locals.region_short
  location              = include.region.locals.region_full
}

inputs = {

  resource_group_name = "rg-${local.lz_environment_hyphen}-afwp-${local.location_short}-001"
  location            = local.location
  ip_groups = [
    {
      name        = "ipgrp-${local.lz_environment_hyphen}-afwp-${local.location_short}-001"
      cidr_ranges = ["10.128.0.0/9"]
    }
  ]
  base_policy_name = "afwp-${local.lz_environment_hyphen}-afwp-${local.location_short}-001"
  base_policy_sku  = "Standard"
  base_policy_rule_collection_groups = [
    {
      name     = "afwp-${local.lz_environment_hyphen}-afwp-${local.location_short}-001"
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
              source_ip_group_references = ["ipgrp-${local.lz_environment_hyphen}-afwp-${local.location_short}-001"]
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
              source_ip_group_references = ["ipgrp-${local.lz_environment_hyphen}-afwp-${local.location_short}-001"]
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
              source_ip_group_references = ["ipgrp-${local.lz_environment_hyphen}-afwp-${local.location_short}-001"]
              destination_addresses      = ["0.0.0.0/0"]
              protocols                  = ["TCP"]
              destination_ports          = ["1-65535"]
            },
            {
              name                       = "udp-all"
              description                = "allow all"
              action                     = "Allow"
              source_ip_group_references = ["ipgrp-${local.lz_environment_hyphen}-afwp-${local.location_short}-001"]
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
      name = "afwp-${local.lz_environment_hyphen}-afwp-${local.location_short}-002"
      dns = {
        proxy_enabled = true
        servers       = ["10.128.3.4"]
      }
    }
  ]
  log_analytics_workspace_name                = "log-mgmt-${include.environment.environment_name}-log-${local.location_short}-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-${include.environment.environment_name}-log-${local.location_short}-001"
  tags                                        = local.tags
}
