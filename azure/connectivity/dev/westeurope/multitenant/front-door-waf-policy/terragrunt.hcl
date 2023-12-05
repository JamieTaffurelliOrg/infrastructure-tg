terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-frontdoorwaf-tf///?ref=0.0.7"
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
  subscription_id = ${include.azure.locals.conn_dev_subscription_id}

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
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { workload = "front-door" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.landing_zone_name}-${include.environment.environment_name}"
  lz_environment_concat = "${include.landing_zone.landing_zone_name}${include.environment.environment_name}"
  location_short        = include.region.region_short
  location              = include.region.region_full
}

inputs = {

  resource_group_name = "rg-${local.lz_environment_hyphen}-fdfp-${local.location_short}-001"
  waf_policy_name     = "fdfp${local.lz_environment_concat}fdfp${local.location_short}001"
  mode                = "Detection"
  custom_rules = [
    {
      name     = "GeoFilteringRemoteAddress"
      action   = "Block"
      priority = 100
      type     = "MatchRule"
      match_conditions = [
        {
          name           = "restricted-countries-remote-address"
          match_variable = "RemoteAddr"
          operator       = "GeoMatch"
          match_values   = ["BY", "RU"]
        }
      ]
    },
    {
      name     = "GeoFilteringSocketAddress"
      action   = "Block"
      priority = 200
      type     = "MatchRule"
      match_conditions = [
        {
          name           = "restricted-countries-socket-address"
          match_variable = "SocketAddr"
          operator       = "GeoMatch"
          match_values   = ["BY", "RU"]
        }
      ]
    }
  ]
  managed_rules = [
    {
      name    = "MicrosoftDefaultRuleSet"
      type    = "Microsoft_DefaultRuleSet"
      version = "2.1"
      action  = "Block"
    },
    {
      name    = "MicrosoftBotManagerRuleSet"
      type    = "Microsoft_BotManagerRuleSet"
      version = "1.0"
      action  = "Block"
    }
  ]
  tags = merge(local.tags, { workload = "front-door" })
}
