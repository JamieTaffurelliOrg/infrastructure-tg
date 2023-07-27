terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-vmimagegallery-tf///?ref=0.0.6"
}

include {
  path = find_in_parent_folders()
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "3bdf403f-77ac-4879-8fba-fa41c2cc94ee"

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
    environment         = "shared"
    stack               = "management"
  }
}

inputs = {

  resource_group_name       = "rg-mgmt-shrd-vmimg-weu1-001"
  location                  = "westeurope"
  image_gallery_name        = "galmgmtshrdvmimgweu1001"
  image_gallery_description = "Store and share compliant VM images for deployment of VMs"
  images = [
    {
      name               = "win-2022-server-azure"
      os_type            = "Windows"
      description        = "Base windows 2022 server"
      publisher          = "MicrosoftWindowsServer"
      offer              = "WindowsServer"
      sku                = "2022-datacenter-azure-edition"
      hyper_v_generation = "V2"
    }
  ]
  storage_account_name = "stjtmgmtshrdvmimgweu1001"
  storage_account_network_rules = {
    default_action = "Allow"
  }
  log_analytics_workspace = {
    name                = "log-mgmt-prod-log-weu1-001"
    resource_group_name = "rg-mgmt-prod-log-weu1-001"
  }
  tags = merge(local.tags, { workload = "vm-images" })
}
