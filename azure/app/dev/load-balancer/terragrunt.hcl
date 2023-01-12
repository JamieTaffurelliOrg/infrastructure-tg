terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-loadbalancer-tf///?ref=0.0.3"
}

include {
  path = find_in_parent_folders()
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "e1806152-a836-4eed-b591-d76f6267b6d2"

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

  resource_group_name = "rg-app-dev-lb-wus2-001"
  location            = "westus2"
  load_balancer_name  = "lbi-app-dev-lb-wus2-001"
  subnets = [
    {
      name                 = "snet-web"
      virtual_network_name = "vnet-app-dev-net-wus2-001"
      resource_group_name  = "rg-app-dev-net-wus2-001"
    }
  ]
  virtual_networks = [
    {
      name                = "vnet-app-dev-net-wus2-001"
      resource_group_name = "rg-app-dev-net-wus2-001"
    }
  ]
  frontend_ip_configurations = [
    {
      name               = "frontend-internal-web-ip"
      subnet_reference   = "snet-web"
      private_ip_address = "10.192.2.4"
    }
  ]
  backend_address_pools = [
    "web-backend-pool"
  ]
  backend_address_pool_addresses = [
    {
      name                           = "web-vm"
      backend_address_pool_reference = "web-backend-pool"
      virtual_network_reference      = "vnet-app-dev-net-wus2-001"
      ip_address                     = "10.192.2.8"
    }
  ]
  probes = [
    {
      name     = "Https-probe"
      port     = 443
      protocol = "Https"
    }
  ]
  rules = [
    {
      name                            = "https-rule"
      protocol                        = "Tcp"
      frontend_port                   = 443
      backend_port                    = 443
      frontend_ip_configuration_name  = "frontend-internal-web-ip"
      backend_address_pool_references = ["web-vm"]
      probe_references                = "Https-probe"
    }
  ]
  tags = merge(local.tags, { workload-name = "network" })
}
