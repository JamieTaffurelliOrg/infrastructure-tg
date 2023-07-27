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

  resource_group_name = "rg-conn-dev-bas-weu1-001"
  location            = "westeurope"
  network_security_groups = [
    {
      name                = "nsg-conn-dev-bas-weu1-001"
      resource_group_name = "rg-conn-dev-bas-weu1-001"
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
  virtual_network_name          = "vnet-conn-dev-bas-weu1-001"
  virtual_network_address_space = ["10.128.2.0/24"]
  subnets = [
    {
      name                                          = "AzureBastionSubnet"
      private_endpoint_network_policies_enabled     = false
      private_link_service_network_policies_enabled = false
      address_prefixes                              = ["10.128.2.0/25"]
      network_security_group_reference              = "nsg-conn-dev-bas-weu1-001"
    }
  ]
  network_watcher_name                        = "nw-app-dev-netwat-weu1-001"
  network_watcher_resource_group_name         = "rg-app-dev-netwat-weu1-001"
  log_analytics_workspace_name                = "log-mgmt-dev-log-weu1-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-dev-log-weu1-001"
  storage_account_name                        = "stjtmgmtdevlogweu1002"
  storage_account_resource_group_name         = "rg-mgmt-dev-log-weu1-001"
  tags                                        = merge(local.tags, { workload = "bastion" })
}
