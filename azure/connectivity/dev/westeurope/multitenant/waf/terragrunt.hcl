terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-waf-tf///?ref=0.0.6"
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

  resource_group_name = "rg-conn-dev-waf-weu1-001"
  waf_policy_name     = "wafconndevwafweu1001"
  location            = "westeurope"
  mode                = "Detection"
  managed_rules = {
    managed_rule_sets = [
      {
        name    = "owasp-ruleset"
        type    = "OWASP"
        version = "3.2"
      }
    ]
  }
  tags = merge(local.tags, { workload = "waf" })
}
