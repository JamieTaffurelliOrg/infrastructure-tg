terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-hubvirtualnetwork-tf///?ref=0.0.3"
}

remote_state {

  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    resource_group_name  = "rg-conn-dev-tf-frc1-001"
    storage_account_name = "stjtconndevtffrc1001"
    container_name       = "conn-dev"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    use_azuread_auth     = true
  }
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "58b4ad6f-a160-4b9e-841b-e177f66137c9"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
  subscription_id = "4593b317-03e9-4533-9f41-e0d4b6da338c"

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

  resource_group_name = "rg-conn-dev-hub-wus1-001"
  location            = "westus"
  network_security_groups = [
    {
      name                = "nsg-conn-dev-hub-wus1-001"
      resource_group_name = "rg-conn-dev-hub-wus1-001"
      rules = [
        {
          name                       = "nsgsr-in-deny-any"
          description                = "Deny all inbound traffic"
          priority                   = 4000
          direction                  = "Inbound"
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
      name                = "rt-conn-dev-hub-wus1-001"
      resource_group_name = "rg-conn-dev-hub-wus1-001"
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
  network_watcher_name                = "nw-mgmt-dev-log-wus-001"
  network_watcher_resource_group_name = "rg-mgmt-dev-log-wus1-001"
  virtual_network_name                = "vnet-conn-dev-hub-wus1-001"
  virtual_network_address_space       = "10.0.0.0/16"
  subnets = [
    {
      name                             = "snet-githubactions"
      address_prefixes                 = ["10.0.2.0/24"]
      network_security_group_reference = "nsg-conn-dev-hub-wus1-001"
      route_table_reference            = "rt-conn-dev-hub-wus1-001"
    }
  ]
  firewall_subnet_address_prefixes = ["10.0.0.0/24"]
  bastion_subnet_address_prefixes  = ["10.0.1.0/24"]
  public_ip_prefixes = [
    {
      name          = "ippre-conn-dev-hub-wus1-001"
      ip_version    = "IPv4"
      prefix_length = 30
    },
    {
      name          = "ippre-conn-dev-hub-wus1-002"
      ip_version    = "IPv6"
      prefix_length = 30
    }
  ]
  log_analytics_workspace_name                = "log-mgmt-dev-log-wus1-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-dev-log-wus1-001"
  storage_account_name                        = "stjtmgmtdevlogwus1001"
  storage_account_resource_group_name         = "rg-mgmt-dev-log-wus1-001"
  tags                                        = merge(local.tags, { workload-name = "hub" })
}
