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

  resource_group_name = "rg-conn-dev-fdfp-weu1-001"
  waf_policy_name     = "fdfpconndevfdfpweu1001"
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
