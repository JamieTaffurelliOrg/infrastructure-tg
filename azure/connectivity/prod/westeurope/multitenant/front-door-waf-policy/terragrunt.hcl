terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-frontdoorwaf-tf///?ref=0.0.6"
}

include {
  path = find_in_parent_folders()
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "5091f2ec-a527-4b51-8e63-9f5de65e3a66"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
  subscription_id = "354a71d2-11ed-4c91-abb2-a08a2b4abe69"

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

  resource_group_name = "rg-conn-prod-fdfp-weu1-001"
  waf_policy_name     = "fdfpconnprodfdfpweu1001"
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
  tags = merge(local.tags, { workload-name = "front-door" })
}
