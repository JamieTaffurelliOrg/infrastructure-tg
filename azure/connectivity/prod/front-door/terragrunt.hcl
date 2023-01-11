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
  subscription_id = "9689d784-a98b-49f0-8601-43a18ce83ab4"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
  subscription_id = "510b35a4-6985-403e-939b-305da79e99bc"

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
    stack               = "connectivity"
  }
}

inputs = {

  resource_group_name            = "rg-conn-prod-afd-wus2-001"
  front_door_profile_name        = "afdconnprodafdwus2001"
  waf_policy_name                = "fdfpconnprodfdfpwus2001"
  waf_policy_resource_group_name = "rg-conn-prod-fdfp-wus2-001"
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
        "https" = {
          protocol = "Https"
        }
      }
    }
  ]
  front_door_origins = [
    {
      name                   = "blog-origin"
      origin_group_reference = "blog-og"
      host_name              = "internal.blog.jamietaffurelli.com"
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
      forwarding_protocol      = "HttpsOnly"
      patterns_to_match        = ["/*"]
      supported_protocols      = ["Http", "Https"]
      custom_domain_references = ["jamietaffurelli-blog-cd"]
      link_to_default_domain   = true
    }
  ]
  front_door_security_policy = {
    name                     = "waf-association"
    custom_domain_references = ["jamietaffurelli-blog-cd"]
  }
  log_analytics_workspace_name                = "log-mgmt-prod-log-wus2-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-prod-log-wus2-001"
  tags                                        = merge(local.tags, { workload-name = "front-door" })
}
