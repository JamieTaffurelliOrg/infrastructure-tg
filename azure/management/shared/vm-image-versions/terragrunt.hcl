terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-vmimagetemplate-tf///?ref=0.0.7"
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

  resource_group_name         = "rg-mgmt-shrd-vmimg-weu1-001"
  location                    = "westeurope"
  user_assigned_identity_name = "galmgmtshrdvmimgweu1001"
  gallery_name                = "galmgmtshrdvmimgweu1001"
  windows_image_templates = [
    {
      name       = "win2022azimg"
      image_name = "win-2022-server-azure"
      artifact_tags = {
        "os" : "Windows",
        "version" : "2022",
        "flavour" : "Azure"
      }
      hardening_script_url = "https://stjtmgmtshrdvmimgweu1001.blob.core.windows.net/scripts/windows-server-hardening.ps1"
    }
  ]
  tags = merge(local.tags, { workload-name = "images" })
}
