terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-hubvirtualnetwork-tf///?ref=0.0.25"
}

include "azure" {
  path = find_in_parent_folders("azure.hcl")
}

include "connectivity" {
  path = find_in_parent_folders("connectivity.hcl")
}

include "dev" {
  path = find_in_parent_folders("dev.hcl")
}

include "westeurope" {
  path = find_in_parent_folders("westeurope.hcl")
}

include "multitenant" {
  path = find_in_parent_folders("multitenant.hcl")
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

provider "azurerm" {
  alias = "spoke"
  subscription_id = "5284e392-c44d-444a-bf2e-07452a860241"

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

  resource_group_name = "rg-conn-dev-hub-weu1-001"
  location            = "westeurope"
  network_security_groups = [
    {
      name                = "nsg-conn-dev-hub-weu1-001"
      resource_group_name = "rg-conn-dev-hub-weu1-001"
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
      name                = "rt-conn-dev-hub-weu1-001"
      resource_group_name = "rg-conn-dev-hub-weu1-001"
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
  virtual_network_name          = "vnet-conn-dev-hub-weu1-001"
  virtual_network_address_space = ["10.128.0.0/16"]
  subnets = [
    {
      name                             = "snet-githubactions"
      address_prefixes                 = ["10.128.2.0/24"]
      network_security_group_reference = "nsg-conn-dev-hub-weu1-001"
      route_table_reference            = "rt-conn-dev-hub-weu1-001"
    }
  ]
  firewall_subnet_address_prefixes    = ["10.128.0.0/24"]
  bastion_network_security_group_name = "nsg-conn-dev-hub-weu1-002"
  bastion_subnet_address_prefixes     = ["10.128.1.0/24"]
  peerings = [
    {
      remote_vnet_name                = "vnet-app-dev-net-weu1-001"
      remote_vnet_resource_group_name = "rg-app-dev-net-weu1-001"
    }
  ]
  public_ip_prefixes = [
    {
      name          = "ippre-conn-dev-hub-weu1-001"
      ip_version    = "IPv4"
      prefix_length = 31
    },
    {
      name          = "ippre-conn-dev-hub-weu1-002"
      ip_version    = "IPv6"
      prefix_length = 126
    }
  ]
  private_dns_zones = [
    {
      name                = "privatelink.azure-automation.net"
      resource_group_name = "rg-conn-dev-prvdns-weu1-001"
    },
    {
      name                = "privatelink.database.windows.net"
      resource_group_name = "rg-conn-dev-prvdns-weu1-001"
    },
    {
      name                = "privatelink.blob.core.windows.net"
      resource_group_name = "rg-conn-dev-prvdns-weu1-001"
    },
    {
      name                = "privatelink.table.core.windows.net"
      resource_group_name = "rg-conn-dev-prvdns-weu1-001"
    },
    {
      name                = "privatelink.queue.core.windows.net"
      resource_group_name = "rg-conn-dev-prvdns-weu1-001"
    },
    {
      name                = "privatelink.file.core.windows.net"
      resource_group_name = "rg-conn-dev-prvdns-weu1-001"
    },
    {
      name                = "privatelink.web.core.windows.net"
      resource_group_name = "rg-conn-dev-prvdns-weu1-001"
    },
    {
      name                = "privatelink.batch.azure.com"
      resource_group_name = "rg-conn-dev-prvdns-weu1-001"
    },
    {
      name                = "privatelink.vaultcore.azure.net"
      resource_group_name = "rg-conn-dev-prvdns-weu1-001"
    },
    {
      name                 = "weu1.internal.jamietaffurellidev.com"
      resource_group_name  = "rg-conn-dev-prvdns-weu1-001"
      registration_enabled = true
    }
  ]
  network_watcher_name                        = "nw-conn-dev-netwat-weu1-001"
  network_watcher_resource_group_name         = "rg-conn-dev-netwat-weu1-001"
  log_analytics_workspace_name                = "log-mgmt-dev-log-weu1-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-dev-log-weu1-001"
  storage_account_name                        = "stjtmgmtdevlogweu1002"
  storage_account_resource_group_name         = "rg-mgmt-dev-log-weu1-001"
  tags                                        = merge(local.tags, { workload = "hub" })
}
