terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-appgw-tf///?ref=0.0.4"
}

include {
  path = find_in_parent_folders()
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

provider "azurerm" {
  alias = "public_ip_prefix"
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

  public_ip_addresses = [
    {
      name              = "pip-app-dev-apgw-weu1-001"
      domain_name_label = "pip-app-dev-agw-weu1-001"
    }
  ]
  public_ip_prefix_name                = "ippre-conn-dev-pip-weu1-001"
  public_ip_prefix_resource_group_name = "rg-conn-dev-pip-weu1-001"
  app_gateway_name                     = "agw-app-dev-agw-weu1-001"
  zones                                = null
  firewall_policy_id                   = "test"
  sku_capacity                         = 1
  subnets = [
    {
      name                 = "snet-appgw"
      virtual_network_name = "vnet-app-dev-net-weu1-001"
      resource_group_name  = "rg-app-dev-net-weu1-001"
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
      name                          = "frontendip-01"
      public_ip_address_reference   = "pip-app-dev-apgw-weu1-001"
      subnet_reference              = "snet-appgw"
      private_ip_address            = "10.192.0.254"
      private_ip_address_allocation = "Static"
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
    }
  ]
  http_listeners = [
    {
      name                           = "httplistener-01"
      frontend_ip_configuration_name = "frontendip-01"
      frontend_port_name             = "frontendport-80"
      host_names                     = "test.com"
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
      name = "probe-01"
    }
  ]
  /*ssl_certificates = [
    {
      name                = "sslcert-01"
      key_vault_secret_id = string
    }
  ]*/
  autoscale_configuration = [
    {
      min_capacity               = 0
      response_buffering_enabled = 1
    }
  ]
  log_analytics_workspace_name                = "log-mgmt-dev-log-weu1-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-dev-log-weu1-001"
  tags                                        = merge(local.tags, { workload = "app-gateway" })
}