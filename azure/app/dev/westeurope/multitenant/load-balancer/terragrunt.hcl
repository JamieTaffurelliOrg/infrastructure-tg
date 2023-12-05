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

include "region" {
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
  subscription_id = ${include.azure.locals.app_dev_subscription_id}

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
  subscription_id = ${include.azure.locals.mgmt_dev_subscription_id}

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
  lz_environment_hyphen = "${include.landing_zone.landing_zone_name}-${include.environment.environment_name}"
  lz_environment_concat = "${include.landing_zone.landing_zone_name}${include.environment.environment_name}"
  location_short        = include.region.region_short
  location              = include.region.region_full
}

inputs = {

  resource_group_name = "rg-${local.lz_environment_hyphen}-lb-${local.location_short}-001"
  location            = local.location
  load_balancer_name  = "lbi-${local.lz_environment_hyphen}-lb-${local.location_short}-001"
  subnets = [
    {
      name                 = "snet-web"
      virtual_network_name = "vnet-${local.lz_environment_hyphen}-net-${local.location_short}-001"
      resource_group_name  = "rg-${local.lz_environment_hyphen}-net-${local.location_short}-001"
    }
  ]
  virtual_networks = [
    {
      name                = "vnet-${local.lz_environment_hyphen}-net-${local.location_short}-001"
      resource_group_name = "rg-${local.lz_environment_hyphen}-net-${local.location_short}-001"
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
      auto_approval_subscription_ids       = [include.azure.locals.conn_dev_subscription_id, include.azure.locals.app_dev_subscription_id]
      visibility_subscription_ids          = [include.azure.locals.conn_dev_subscription_id, include.azure.locals.app_dev_subscription_id]
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
  log_analytics_workspace_name                = "log-mgmt-${include.environment.environment_name}-log-${local.location_short}-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-${include.environment.environment_name}-log-${local.location_short}-001"
  tags                                        = local.tags
}
