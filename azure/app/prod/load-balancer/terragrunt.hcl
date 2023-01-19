terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-loadbalancer-tf///?ref=0.0.8"
}

include {
  path = find_in_parent_folders()
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "018499bc-61fd-4799-8107-d4ff6616527e"

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
    stack               = "app"
  }
}

inputs = {

  resource_group_name = "rg-app-prod-lb-weu1-001"
  location            = "westeurope"
  load_balancer_name  = "lbi-app-prod-lb-weu1-001"
  subnets = [
    {
      name                 = "snet-web"
      virtual_network_name = "vnet-app-prod-net-weu1-001"
      resource_group_name  = "rg-app-prod-net-weu1-001"
    }
  ]
  virtual_networks = [
    {
      name                = "vnet-app-prod-net-weu1-001"
      resource_group_name = "rg-app-prod-net-weu1-001"
    }
  ]
  frontend_ip_configurations = [
    {
      name               = "frontend-internal-web-ip"
      subnet_reference   = "snet-web"
      private_ip_address = "10.64.2.4"
    }
  ]
  backend_address_pools = [
    "web-backend-pool"
  ]
  backend_address_pool_addresses = [
    {
      name                           = "web-vm"
      backend_address_pool_reference = "web-backend-pool"
      virtual_network_reference      = "vnet-app-prod-net-weu1-001"
      private_ip_address             = "10.64.2.8"
    }
  ]
  probes = [
    {
      name                = "Https-probe"
      port                = 443
      protocol            = "Https"
      request_path        = "/"
      interval_in_seconds = 10
      number_of_probes    = 1
    }
  ]
  rules = [
    {
      name                            = "https-rule"
      protocol                        = "Tcp"
      frontend_port                   = 443
      backend_port                    = 443
      frontend_ip_configuration_name  = "frontend-internal-web-ip"
      backend_address_pool_references = ["web-backend-pool"]
      probe_reference                 = "Https-probe"
    }
  ]
  tags = merge(local.tags, { workload-name = "network" })
}
