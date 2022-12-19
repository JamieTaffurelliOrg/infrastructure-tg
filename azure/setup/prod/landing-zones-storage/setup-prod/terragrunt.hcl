terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-landingzone-storage-tf///?ref=0.0.3"
}

include {
  path = find_in_parent_folders()
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "105036b2-81a9-4d2d-955b-74e9aead3b29"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
  subscription_id = "58b4ad6f-a160-4b9e-841b-e177f66137c9"

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
    workload-name       = "tfstate"
    data-classification = "confidential"
    criticality         = "mission-critical"
    ops-commitment      = "workload-operations"
    ops-team            = "sre"
    cost-owner          = "jltaffurelli@outlook.com"
    owner               = "jltaffurelli@outlook.com"
    sla                 = "high"
  }
}

inputs = {

  storage_account_name = "stjtstpprodtffrc1001"
  location             = "francecentral"
  resource_group_name  = "rg-stp-prod-tf-frc1-001"
  containers           = ["setup-prod"]
  storage_account_network_rules = {
    default_action = "Allow"
  }

  /*log_analytics_workspace = {
    name                = "logs"
    resource_group_name = "logs"
  }*/
  tags = merge(local.tags, { environment = "prod", stack = "setup" })
}
