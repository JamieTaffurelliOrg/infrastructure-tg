terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-spokevirtualnetwork-tf//spoke-vnet-vhub///?ref=0.0.23"
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
  subscription_id = "${include.azure.locals.app_dev_subscription_id}"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
  subscription_id = "${include.azure.locals.mgmt_dev_subscription_id}"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "ddos"
  subscription_id = "${include.azure.locals.conn_dev_subscription_id}"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "dns"
  subscription_id = "${include.azure.locals.conn_dev_subscription_id}"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "hub"
  subscription_id = "${include.azure.locals.conn_dev_subscription_id}"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
EOF

}

locals {
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { workload = "network" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.locals.landing_zone_name}-${include.environment.locals.environment_name}"
  lz_environment_concat = "${include.landing_zone.locals.landing_zone_name}${include.environment.locals.environment_name}"
  location_short        = include.region.locals.region_short
  location              = include.region.locals.region_full
}

inputs = {

  resource_group_name = "rg-${local.lz_environment_hyphen}-net-${local.location_short}-001"
  location            = local.location
  network_security_groups = [
    {
      name                = "nsg-${local.lz_environment_hyphen}-net-${local.location_short}-001"
      resource_group_name = "rg-${local.lz_environment_hyphen}-net-${local.location_short}-001"
      rules = [
        {
          name                       = "nsgsr-in-allow-any-any"
          description                = "Deny all inbound traffic"
          priority                   = 3999
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
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
          name                       = "nsgsr-out-allow-any-any"
          description                = "Deny all outbound traffic"
          priority                   = 3999
          direction                  = "Outbound"
          access                     = "Allow"
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
    },
    {
      name                = "nsg-${local.lz_environment_hyphen}-net-${local.location_short}-002"
      resource_group_name = "rg-${local.lz_environment_hyphen}-net-${local.location_short}-001"
      rules = [
        {
          name                       = "nsgsr-in-allow-any-any"
          description                = "Deny all inbound traffic"
          priority                   = 3999
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
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
          name                       = "nsgsr-out-allow-any-any"
          description                = "Deny all outbound traffic"
          priority                   = 3999
          direction                  = "Outbound"
          access                     = "Allow"
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
    },
    {
      name                = "nsg-${local.lz_environment_hyphen}-net-${local.location_short}-003"
      resource_group_name = "rg-${local.lz_environment_hyphen}-net-${local.location_short}-001"
      rules = [
        {
          name                       = "nsgsr-in-allow-any-any"
          description                = "Deny all inbound traffic"
          priority                   = 3999
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
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
          name                       = "nsgsr-out-allow-any-any"
          description                = "Deny all outbound traffic"
          priority                   = 3999
          direction                  = "Outbound"
          access                     = "Allow"
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
  virtual_network_name          = "vnet-${local.lz_environment_hyphen}-net-${local.location_short}-001"
  virtual_network_address_space = ["10.192.0.0/16"]
  subnets = [
    {
      name                             = "snet-appgw"
      address_prefixes                 = ["10.192.0.0/24"]
      network_security_group_reference = "nsg-${local.lz_environment_hyphen}-net-${local.location_short}-00"
    },
    {
      name                             = "snet-privateendpoint"
      address_prefixes                 = ["10.192.1.0/24"]
      network_security_group_reference = "nsg-${local.lz_environment_hyphen}-net-${local.location_short}-002"
    },
    {
      name                             = "snet-cae"
      address_prefixes                 = ["10.192.2.0/23"]
      network_security_group_reference = "nsg-${local.lz_environment_hyphen}-net-${local.location_short}-003"
    },
  ]
  /*hub_connection = {
    name                      = "vhub-conn-${include.environment.locals.environment_name}-vhub-${local.location_short}-001"
    resource_group_name       = "rg-conn-${include.environment.locals.environment_name}-vhub-${local.location_short}-001"
    internet_security_enabled = true
  }*/

  network_watcher_name                        = "nw-${local.lz_environment_hyphen}-netwat-${local.location_short}-001"
  network_watcher_resource_group_name         = "rg-${local.lz_environment_hyphen}-netwat-${local.location_short}-001"
  log_analytics_workspace_name                = "log-mgmt-${include.environment.locals.environment_name}-log-${local.location_short}-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-${include.environment.locals.environment_name}-log-${local.location_short}-001"
  storage_account_name                        = "st${local.org_prefix}mgmt${include.environment.locals.environment_name}log${local.location_short}001"
  storage_account_resource_group_name         = "rg-mgmt-${include.environment.locals.environment_name}-log-${local.location_short}-001"
  tags                                        = local.tags
}
