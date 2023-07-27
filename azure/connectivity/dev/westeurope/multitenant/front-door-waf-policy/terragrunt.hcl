terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-frontdoorwaf-tf///?ref=0.0.7"
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
