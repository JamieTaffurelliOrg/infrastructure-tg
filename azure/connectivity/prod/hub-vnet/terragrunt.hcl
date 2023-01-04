terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-hubvirtualnetwork-tf///?ref=0.0.16"
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
  subscription_id = "510b35a4-6985-403e-939b-305da79e99bc"

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

  resource_group_name = "rg-conn-prod-hub-wus2-001"
  location            = "westus2"
  network_security_groups = [
    {
      name                = "nsg-conn-prod-hub-wus2-001"
      resource_group_name = "rg-conn-prod-hub-wus2-001"
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
      name                = "rt-conn-prod-hub-wus2-001"
      resource_group_name = "rg-conn-prod-hub-wus2-001"
      routes = [
        {
          name                   = "udr-azurefirewall"
          address_prefix         = "0.0.0.0/0"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "1.0.0.4"
        }
      ]
    }
  ]
  virtual_network_name          = "vnet-conn-prod-hub-wus2-001"
  virtual_network_address_space = ["10.0.0.0/16"]
  subnets = [
    {
      name                             = "snet-githubactions"
      address_prefixes                 = ["10.0.2.0/24"]
      network_security_group_reference = "nsg-conn-prod-hub-wus2-001"
      route_table_reference            = "rt-conn-prod-hub-wus2-001"
    }
  ]
  firewall_subnet_address_prefixes    = ["10.0.0.0/24"]
  bastion_network_security_group_name = "nsg-conn-prod-hub-wus2-002"
  bastion_subnet_address_prefixes     = ["10.0.1.0/24"]
  public_ip_prefixes = [
    {
      name          = "ippre-conn-prod-hub-wus2-001"
      ip_version    = "IPv4"
      prefix_length = 30
    },
    {
      name          = "ippre-conn-prod-hub-wus2-002"
      ip_version    = "IPv6"
      prefix_length = 126
    }
  ]
  private_dns_zones = [
    {
      name                = "privatelink.azure-automation.net"
      resource_group_name = "rg-conn-prod-prvdns-wus2-001"
    },
    {
      name                = "privatelink.database.windows.net"
      resource_group_name = "rg-conn-prod-prvdns-wus2-001"
    },
    {
      name                = "privatelink.blob.core.windows.net"
      resource_group_name = "rg-conn-prod-prvdns-wus2-001"
    },
    {
      name                = "privatelink.table.core.windows.net"
      resource_group_name = "rg-conn-prod-prvdns-wus2-001"
    },
    {
      name                = "privatelink.queue.core.windows.net"
      resource_group_name = "rg-conn-prod-prvdns-wus2-001"
    },
    {
      name                = "privatelink.file.core.windows.net"
      resource_group_name = "rg-conn-prod-prvdns-wus2-001"
    },
    {
      name                = "privatelink.web.core.windows.net"
      resource_group_name = "rg-conn-prod-prvdns-wus2-001"
    },
    {
      name                = "privatelink.batch.azure.com"
      resource_group_name = "rg-conn-prod-prvdns-wus2-001"
    },
    {
      name                = "privatelink.vaultcore.azure.net"
      resource_group_name = "rg-conn-prod-prvdns-wus2-001"
    }
  ]
  network_watcher_name                        = "nw-conn-prod-netwat-wus2-001"
  network_watcher_resource_group_name         = "rg-conn-prod-netwat-frc1-001"
  log_analytics_workspace_name                = "log-mgmt-prod-log-wus2-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-prod-log-wus2-001"
  storage_account_name                        = "stjtmgmtprodlogwus2001"
  storage_account_resource_group_name         = "rg-mgmt-prod-log-wus2-001"
  tags                                        = merge(local.tags, { workload-name = "hub" })
}
