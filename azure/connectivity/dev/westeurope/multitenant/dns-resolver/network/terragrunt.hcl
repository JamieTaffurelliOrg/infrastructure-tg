terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-spokevirtualnetwork-tf//spoke-vnet-vhub///?ref=0.0.16"
}

include {
  path = find_in_parent_folders()
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
  alias = "ddos"
  subscription_id = "3d6c3571-dbcd-47fa-a4f1-f2993adb6c90"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "hub"
  subscription_id = "3d6c3571-dbcd-47fa-a4f1-f2993adb6c90"

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
    stack               = "app"
  }
}

inputs = {

  resource_group_name = "rg-conn-dev-dnspr-weu1-001"
  location            = "westeurope"
  network_security_groups = [
    {
      name                = "nsg-conn-dev-dnspr-weu1-001"
      resource_group_name = "rg-conn-dev-dnspr-weu1-001"
      rules = [
        {
          name                       = "nsgsr-in-allow-VirtualNetwork-53"
          description                = "Allow VirtualNetwork inbound traffic on 53"
          priority                   = 120
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "53"
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
          name                       = "nsgsr-out-allow-VirtualNetwork-53"
          description                = "Allow VirtualNetwork outbound traffic on 53"
          priority                   = 120
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "53"
          source_address_prefix      = "VirtualNetwork"
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
  virtual_network_name          = "vnet-conn-dev-dnspr-weu1-001"
  virtual_network_address_space = ["10.128.3.0/24"]
  subnets = [
    {
      name                                          = "snet-dnspr-001"
      private_endpoint_network_policies_enabled     = false
      private_link_service_network_policies_enabled = false
      address_prefixes                              = ["10.128.2.0/26"]
      network_security_group_reference              = "nsg-conn-dev-dnspr-weu1-001"
    }
  ]
  private_dns_zones = [
    {
      name                = "privatelink.azure-automation.net"
      resource_group_name = "rg-conn-dev-prvdns-weu1-001"
    },
    {
      name                = "privatelink.redis.cache.windows.net"
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
    }
  ]
  network_watcher_name                        = "nw-conn-dev-netwat-weu1-001"
  network_watcher_resource_group_name         = "rg-conn-dev-netwat-weu1-001"
  log_analytics_workspace_name                = "log-mgmt-dev-log-weu1-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-dev-log-weu1-001"
  storage_account_name                        = "stjtmgmtdevlogweu1002"
  storage_account_resource_group_name         = "rg-mgmt-dev-log-weu1-001"
  tags                                        = merge(local.tags, { workload = "private-dns" })
}
