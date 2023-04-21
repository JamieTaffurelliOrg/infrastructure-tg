terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-frontdoor-tf///?ref=0.0.12"
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

  resource_group_name            = "rg-conn-dev-afd-weu1-001"
  front_door_profile_name        = "afdconndevafdweu1001"
  waf_policy_name                = "fdfpconndevfdfpweu1001"
  waf_policy_resource_group_name = "rg-conn-dev-fdfp-weu1-001"
  front_door_endpoints = [
    {
      name = "jamietaffurelli"
    }
  ]
  front_door_custom_domains = [
    {
      name      = "jamietaffurelli-blog-cd"
      host_name = "blog.jamietaffurelli.com"
    }
  ]
  front_door_origin_groups = [
    {
      name = "blog-og"
      health_probes = {
        "http" = {
          protocol = "Http"
        }
      }
    }
  ]
  front_door_origins = [
    {
      name                   = "blog-origin"
      origin_group_reference = "blog-og"
      host_name              = "vmappdvwebweu11.weu1.internal.jamietaffurellidev.com"
      private_link = {
        "app" = {
          location               = "westeurope"
          private_link_target_id = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-lb-weu1-001/providers/Microsoft.Network/privateLinkServices/web"
        }
      }
    }
  ]
  front_door_routes = [
    {
      name                   = "default"
      endpoint_reference     = "jamietaffurelli"
      origin_group_reference = "blog-og"
      https_redirect_enabled = false
      origin_references = [
        "blog-origin"
      ]
      forwarding_protocol      = "HttpOnly"
      patterns_to_match        = ["/*"]
      supported_protocols      = ["Http"]
      custom_domain_references = ["jamietaffurelli-blog-cd"]
      link_to_default_domain   = true
    }
  ]
  front_door_security_policy = {
    name                     = "waf-association"
    custom_domain_references = ["jamietaffurelli-blog-cd"]
  }
  log_analytics_workspace_name                = "log-mgmt-dev-log-weu1-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-dev-log-weu1-001"
  tags                                        = merge(local.tags, { workload-name = "front-door" })
}
