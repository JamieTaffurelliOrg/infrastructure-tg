terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-frontdoor-tf///?ref=0.0.10"
}

include {
  path = find_in_parent_folders()
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
        target_type            = "sites"
        location               = "westeurope"
        private_link_target_id = "/subscriptions/e1806152-a836-4eed-b591-d76f6267b6d2/resourceGroups/rg-app-dev-lb-weu1-001/providers/Microsoft.Network/loadBalancers/lbi-app-dev-lb-weu1-001"
      }
    }
  ]
  front_door_routes = [
    {
      name                   = "default"
      endpoint_reference     = "jamietaffurelli"
      origin_group_reference = "blog-og"
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
