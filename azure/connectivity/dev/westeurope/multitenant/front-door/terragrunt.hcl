terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-frontdoor-tf///?ref=0.0.17"
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
  subscription_id = "${include.azure.locals.conn_dev_subscription_id}"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
  subscription_id = "${include.azure.locals.mgmt_dev_subscription_id}"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
EOF

}

locals {
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { workload = "front-door" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.locals.landing_zone_name}-${include.environment.locals.environment_name}"
  lz_environment_concat = "${include.landing_zone.locals.landing_zone_name}${include.environment.locals.environment_name}"
  location_short        = include.region.locals.region_short
  location              = include.region.locals.region_full
}

inputs = {

  resource_group_name            = "rg-${local.lz_environment_hyphen}-afd-${local.location_short}-001"
  front_door_profile_name        = "afd${local.lz_environment_concat}afd${local.location_short}001"
  waf_policy_name                = "fdfp${local.lz_environment_concat}fdfp${local.location_short}001"
  waf_policy_resource_group_name = "rg-${local.lz_environment_hyphen}-fdfp-${local.location_short}-001"
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
      host_name              = "vmappdvweb${local.location_short}1.${local.location_short}.internal.jamietaffurellidev.com"
      private_link = {
        "app" = {
          location               = local.location
          private_link_target_id = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-lb-${local.location_short}-001/providers/Microsoft.Network/privateLinkServices/web"
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
  log_analytics_workspace_name                = "log-mgmt-${include.environment.locals.environment_name}-log-${local.location_short}-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-${include.environment.locals.environment_name}-log-${local.location_short}-001"
  tags                                        = local.tags
}
