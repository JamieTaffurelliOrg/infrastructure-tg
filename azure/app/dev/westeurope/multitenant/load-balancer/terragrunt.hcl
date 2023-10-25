terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-loadbalancer-tf///?ref=0.0.11"
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

include "westeurope" {
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
  subscription_id = "5284e392-c44d-444a-bf2e-07452a860241"

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

  resource_group_name = "rg-app-dev-lb-weu1-001"
  location            = "westeurope"
  load_balancer_name  = "lbi-app-dev-lb-weu1-001"
  subnets = [
    {
      name                 = "snet-web"
      virtual_network_name = "vnet-app-dev-net-weu1-001"
      resource_group_name  = "rg-app-dev-net-weu1-001"
    }
  ]
  virtual_networks = [
    {
      name                = "vnet-app-dev-net-weu1-001"
      resource_group_name = "rg-app-dev-net-weu1-001"
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
  probes = [
    {
      name                = "Tcp-probe"
      port                = 80
      protocol            = "Tcp"
      interval_in_seconds = 10
      number_of_probes    = 1
    }
  ]
  rules = [
    {
      name                            = "Tcp-rule"
      protocol                        = "Tcp"
      frontend_port                   = 80
      backend_port                    = 80
      frontend_ip_configuration_name  = "frontend-internal-web-ip"
      backend_address_pool_references = ["web-backend-pool"]
      probe_reference                 = "Tcp-probe"
    }
  ]
  private_link_services = [
    {
      name                                 = "web"
      auto_approval_subscription_ids       = ["3d6c3571-dbcd-47fa-a4f1-f2993adb6c90", "5284e392-c44d-444a-bf2e-07452a860241"]
      visibility_subscription_ids          = ["3d6c3571-dbcd-47fa-a4f1-f2993adb6c90", "5284e392-c44d-444a-bf2e-07452a860241"]
      frontend_ip_configuration_references = ["frontend-internal-web-ip"]
      nat_ip_configurations = [
        {
          name               = "nat1"
          private_ip_address = "10.192.2.5"
          subnet_reference   = "snet-web"
          primary            = true
        }
      ]
    }
  ]
  log_analytics_workspace_name                = "log-mgmt-dev-log-weu1-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-dev-log-weu1-001"
  tags                                        = merge(local.tags, { workload = "network" })
}
