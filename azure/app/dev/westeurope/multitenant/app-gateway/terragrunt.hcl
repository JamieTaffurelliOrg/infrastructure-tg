terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-appgw-tf///?ref=0.0.10"
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

provider "azurerm" {
  alias = "public_ip_prefix"
  subscription_id = ${include.azure.locals.app_dev_subscription_id}

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
EOF

}

locals {
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { workload = "app-gateway" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.locals.landing_zone_name}-${include.environment.locals.environment_name}"
  lz_environment_concat = "${include.landing_zone.locals.landing_zone_name}${include.environment.locals.environment_name}"
  location_short        = include.region.locals.region_short
  location              = include.region.locals.region_full
}

inputs = {

  resource_group_name = "rg-${local.lz_environment_hyphen}-agw-${local.location_short}-001"
  location            = local.location
  public_ip_addresses = [
    {
      name              = "pip-${local.lz_environment_hyphen}-apgw-${local.location_short}-001"
      domain_name_label = "pip-${local.lz_environment_hyphen}-agw-${local.location_short}-001"
    }
  ]
  public_ip_prefix_name                = "ippre-${local.lz_environment_hyphen}-pip-${local.location_short}-001"
  public_ip_prefix_resource_group_name = "rg-${local.lz_environment_hyphen}-pip-${local.location_short}-001"
  app_gateway_name                     = "agw-${local.lz_environment_hyphen}-agw-${local.location_short}-001"
  zones                                = null
  firewall_policy_id                   = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-${local.lz_environment_hyphen}-waf-${local.location_short}-001/providers/Microsoft.Network/applicationGatewayWebApplicationFirewallPolicies/waf${local.lz_environment_concat}waf${local.location_short}001"
  sku_capacity                         = 1
  fips_enabled                         = false
  subnets = [
    {
      name                 = "snet-appgw"
      virtual_network_name = "vnet-${local.lz_environment_hyphen}net-${local.location_short}-001"
      resource_group_name  = "rg-${local.lz_environment_hyphen}-net-${local.location_short}-001"
    }
  ]
  gateway_ip_configurations = [
    {
      name             = "gatewayip-01"
      subnet_reference = "snet-appgw"
    }
  ]
  front_end_ports = [
    {
      name = "frontendport-80"
      port = 80
    }
  ]
  frontend_ip_configurations = [
    {
      name                        = "frontendip-01"
      public_ip_address_reference = "pip-${local.lz_environment_hyphen}-apgw-${local.location_short}-001"
    }
  ]
  backend_address_pools = [
    {
      name  = "backendpool-01"
      fqdns = ["test.com"]
    }
  ]
  backend_http_settings = [
    {
      name       = "backendsetting-01"
      probe_name = "probe-01"
      port       = 80
      protocol   = "Http"
    }
  ]
  http_listeners = [
    {
      name                           = "httplistener-01"
      frontend_ip_configuration_name = "frontendip-01"
      frontend_port_name             = "frontendport-80"
      host_names                     = ["test.com"]
      protocol                       = "Http"
    }
  ]
  request_routing_rules = [
    {
      name                       = "routerule-01"
      http_listener_name         = "httplistener-01"
      backend_address_pool_name  = "backendpool-01"
      backend_http_settings_name = "backendsetting-01"
      priority                   = 1
    }
  ]
  probes = [
    {
      name     = "probe-01"
      protocol = "Http"
      port     = 80
    }
  ]
  /*ssl_certificates = [
    {
      name                = "sslcert-01"
      key_vault_secret_id = string
    }
  ]*/
  autoscale_configuration                     = null
  log_analytics_workspace_name                = "log-mgmt-${include.environment.environment_name}-log-${local.location_short}-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-${include.environment.environment_name}-log-${local.location_short}-001"
  tags                                        = local.tags
}
