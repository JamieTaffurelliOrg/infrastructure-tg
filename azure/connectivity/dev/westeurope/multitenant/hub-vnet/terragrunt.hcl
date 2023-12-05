terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-hubvirtualnetwork-tf///?ref=0.0.25"
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

include "region" {
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

provider "azurerm" {
  alias = "spoke"
  subscription_id = ${include.azure.locals.app_dev_subscription_id}

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
EOF

}

locals {
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { workload = "hub" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.landing_zone_name}-${include.environment.environment_name}"
  lz_environment_concat = "${include.landing_zone.landing_zone_name}${include.environment.environment_name}"
  location_short        = include.region.region_short
  location              = include.region.region_full
}

inputs = {

  resource_group_name = "rg-${local.lz_environment_hyphen}-hub-${local.location_short}-001"
  location            = local.location
  network_security_groups = [
    {
      name                = "nsg-${local.lz_environment_hyphen}-hub-${local.location_short}-001"
      resource_group_name = "rg-${local.lz_environment_hyphen}-hub-${local.location_short}-001"
      rules = [
        {
          name                       = "nsgsr-in-deny-any-any"
          description                = "Deny all inbound traffic"
          priority                   = 4000
          direction                  = "Inbound"
          access                     = "Deny"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "nsgsr-out-deny-any-any"
          description                = "Deny all outbound traffic"
          priority                   = 4000
          direction                  = "Outbound"
          access                     = "Deny"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    }
  ]
  route_tables = [
    {
      name                = "rt-${local.lz_environment_hyphen}-hub-${local.location_short}-001"
      resource_group_name = "rg-${local.lz_environment_hyphen}-hub-${local.location_short}-001"
      routes = [
        {
          name                   = "udr-azurefirewall"
          address_prefix         = "0.0.0.0/0"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.128.0.4"
        }
      ]
    }
  ]
  virtual_network_name          = "vnet-${local.lz_environment_hyphen}-hub-${local.location_short}-001"
  virtual_network_address_space = ["10.128.0.0/16"]
  subnets = [
    {
      name                             = "snet-githubactions"
      address_prefixes                 = ["10.128.2.0/24"]
      network_security_group_reference = "nsg-${local.lz_environment_hyphen}-hub-${local.location_short}-001"
      route_table_reference            = "rt-${local.lz_environment_hyphen}-hub-${local.location_short}-001"
    }
  ]
  firewall_subnet_address_prefixes    = ["10.128.0.0/24"]
  bastion_network_security_group_name = "nsg-${local.lz_environment_hyphen}-hub-${local.location_short}-002"
  bastion_subnet_address_prefixes     = ["10.128.1.0/24"]
  peerings = [
    {
      remote_vnet_name                = "vnet-app-dev-net-${local.location_short}-001"
      remote_vnet_resource_group_name = "rg-app-dev-net-${local.location_short}-001"
    }
  ]
  public_ip_prefixes = [
    {
      name          = "ippre-${local.lz_environment_hyphen}-hub-${local.location_short}-001"
      ip_version    = "IPv4"
      prefix_length = 31
    },
    {
      name          = "ippre-${local.lz_environment_hyphen}-hub-${local.location_short}-002"
      ip_version    = "IPv6"
      prefix_length = 126
    }
  ]
  private_dns_zones = [
    {
      name                = "privatelink.azure-automation.net"
      resource_group_name = "rg-${local.lz_environment_hyphen}-prvdns-${local.location_short}-001"
    },
    {
      name                = "privatelink.database.windows.net"
      resource_group_name = "rg-${local.lz_environment_hyphen}-prvdns-${local.location_short}-001"
    },
    {
      name                = "privatelink.blob.core.windows.net"
      resource_group_name = "rg-${local.lz_environment_hyphen}-prvdns-${local.location_short}-001"
    },
    {
      name                = "privatelink.table.core.windows.net"
      resource_group_name = "rg-${local.lz_environment_hyphen}-prvdns-${local.location_short}-001"
    },
    {
      name                = "privatelink.queue.core.windows.net"
      resource_group_name = "rg-${local.lz_environment_hyphen}-prvdns-${local.location_short}-001"
    },
    {
      name                = "privatelink.file.core.windows.net"
      resource_group_name = "rg-${local.lz_environment_hyphen}-prvdns-${local.location_short}-001"
    },
    {
      name                = "privatelink.web.core.windows.net"
      resource_group_name = "rg-${local.lz_environment_hyphen}-prvdns-${local.location_short}-001"
    },
    {
      name                = "privatelink.batch.azure.com"
      resource_group_name = "rg-${local.lz_environment_hyphen}-prvdns-${local.location_short}-001"
    },
    {
      name                = "privatelink.vaultcore.azure.net"
      resource_group_name = "rg-${local.lz_environment_hyphen}-prvdns-${local.location_short}-001"
    },
    {
      name                 = "${local.location_short}.internal.jamietaffurellidev.com"
      resource_group_name  = "rg-${local.lz_environment_hyphen}-prvdns-${local.location_short}-001"
      registration_enabled = true
    }
  ]
  network_watcher_name                        = "nw-${local.lz_environment_hyphen}-netwat-${local.location_short}-001"
  network_watcher_resource_group_name         = "rg-${local.lz_environment_hyphen}-netwat-${local.location_short}-001"
  log_analytics_workspace_name                = "log-mgmt-${include.environment.environment_name}-log-${local.location_short}-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-${include.environment.environment_name}-log-${local.location_short}-001"
  storage_account_name                        = "st${local.org_prefix}mgmt${include.environment.environment_name}log${local.location_short}002"
  storage_account_resource_group_name         = "rg-mgmt-${include.environment.environment_name}-log-${local.location_short}-001"
  tags                                        = local.tags
}
