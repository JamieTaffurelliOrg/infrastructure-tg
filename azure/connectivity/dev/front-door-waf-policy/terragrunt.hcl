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

  resource_group_name = "rg-conn-dev-fdfp-wus2-001"
  waf_policy_name     = "fdfpconndevfdfpwus2001"
  mode                = "Detection"
  custom_rules = [
    {
      name     = "GeoFiltering"
      action   = "Block"
      priority = 1
      type     = "MatchRule"
      match_conditions = [
        {
          name           = "restricted-countries"
          match_variable = "RemoteAddr"
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
