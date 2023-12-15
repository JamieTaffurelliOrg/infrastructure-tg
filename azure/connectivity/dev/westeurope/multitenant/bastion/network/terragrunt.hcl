terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-spokevirtualnetwork-tf//spoke-vnet-vhub///?ref=0.0.20"
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
  subscription_id = ${include.azure.locals.mgmt_dev_subscription_id}iption_id}

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "ddos"
  subscription_id = ${include.azure.locals.conn_dev_subscription_id}

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "dns"
  subscription_id = ${include.azure.locals.conn_dev_subscription_id}

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "hub"
  subscription_id = ${include.azure.locals.conn_dev_subscription_id}

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
EOF

}

locals {
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { workload = "bastion" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.locals.landing_zone_name}-${include.environment.locals.environment_name}"
  lz_environment_concat = "${include.landing_zone.locals.landing_zone_name}${include.environment.locals.environment_name}"
  location_short        = include.region.locals.region_short
  location              = include.region.locals.region_full
}

inputs = {

  resource_group_name = "rg-${local.lz_environment_hyphen}-bas-${local.location_short}-001"
  location            = local.location
  network_security_groups = [
    {
      name                = "nsg-${local.lz_environment_hyphen}-bas-${local.location_short}-001"
      resource_group_name = "rg-${local.lz_environment_hyphen}-bas-${local.location_short}-001"
      rules = [
        {
          name                       = "nsgsr-in-allow-client-443"
          description                = "Allow internet inbound traffic on 443"
          priority                   = 120
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "nsgsr-in-allow-GatewayManager-443"
          description                = "Allow GatewayManager inbound traffic on 443"
          priority                   = 130
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = "GatewayManager"
          destination_address_prefix = "*"
        },
        {
          name                       = "nsgsr-in-allow-AzureLoadBalancer-443"
          description                = "Allow AzureLoadBalancer inbound traffic on 443"
          priority                   = 140
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = "AzureLoadBalancer"
          destination_address_prefix = "*"
        },
        {
          name                       = "nsgsr-in-allow-VirtualNetwork-8080-5701"
          description                = "Allow VirtualNetwork inbound traffic on 8080 and 5701"
          priority                   = 150
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_ranges    = ["8080", "5701"]
          source_address_prefix      = "VirtualNetwork"
          destination_address_prefix = "VirtualNetwork"
        },
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
          name                       = "nsgsr-out-allow-VirtualNetwork-22-3389"
          description                = "Allow VirtualNetwork outbound traffic on 22 and 3389"
          priority                   = 120
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_ranges    = ["22", "3389"]
          source_address_prefix      = "*"
          destination_address_prefix = "VirtualNetwork"
        },
        {
          name                       = "nsgsr-out-allow-AzureCloud-443"
          description                = "Allow AzureCloud outbound traffic on 443"
          priority                   = 130
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = "*"
          destination_address_prefix = "AzureCloud"
        },
        {
          name                       = "nsgsr-out-allow-VirtualNetwork-8080-5701"
          description                = "Allow VirtualNetwork outbound traffic on 8080 and 5701"
          priority                   = 140
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_ranges    = ["8080", "5701"]
          source_address_prefix      = "VirtualNetwork"
          destination_address_prefix = "VirtualNetwork"
        },
        {
          name                       = "nsgsr-out-allow-Internet-80"
          description                = "Allow Internet outbound traffic on 80"
          priority                   = 150
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "80"
          source_address_prefix      = "*"
          destination_address_prefix = "Internet"
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
  virtual_network_name          = "vnet-${local.lz_environment_hyphen}-bas-${local.location_short}-001"
  virtual_network_address_space = ["10.128.2.0/24"]
  subnets = [
    {
      name                                          = "AzureBastionSubnet"
      private_endpoint_network_policies_enabled     = false
      private_link_service_network_policies_enabled = false
      address_prefixes                              = ["10.128.2.0/25"]
      network_security_group_reference              = "nsg-${local.lz_environment_hyphen}-bas-${local.location_short}-001"
    }
  ]
  hub_connection = {
    name                      = "vhub-${local.lz_environment_hyphen}-vhub-${local.location_short}-001"
    resource_group_name       = "rg-${local.lz_environment_hyphen}-vhub-${local.location_short}-001"
    internet_security_enabled = false
  }
  network_watcher_name                        = "nw-${local.lz_environment_hyphen}-netwat-${local.location_short}-001"
  network_watcher_resource_group_name         = "rg-${local.lz_environment_hyphen}-netwat-${local.location_short}-001"
  log_analytics_workspace_name                = "log-mgmt-${include.environment.environment_name}-log-${local.location_short}-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-${include.environment.environment_name}-log-${local.location_short}-001"
  storage_account_name                        = "st${local.org_prefix}mgmt${include.environment.environment_name}log${local.location_short}002"
  storage_account_resource_group_name         = "rg-mgmt-${include.environment.environment_name}-log-${local.location_short}-001"
  tags                                        = local.tags
}
