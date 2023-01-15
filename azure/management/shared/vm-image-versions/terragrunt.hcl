terraform {
  //source = "git::https://github.com/JamieTaffurelliOrg/az-vmimagetemplate-tf///?ref=0.0.4"
  source = "../../../../../az-vmimagetemplate-tf"
}

include {
  path = find_in_parent_folders()
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "a9da0406-a642-49b3-9c2c-c8ed05bb1c85"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
  subscription_id = "510b35a4-6985-403e-939b-305da79e99bc"

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

  resource_group_name         = "rg-mgmt-shrd-vmimg-wus2-001"
  location                    = "westus2"
  user_assigned_identity_name = "galmgmtshrdvmimgwus2001"
  gallery_name                = "galmgmtshrdvmimgwus2001"
  windows_image_templates = [
    {
      name       = "win2022azimg"
      image_name = "win-2022-server-azure"
      artifact_tags = {
        "os" : "Windows",
        "version" : "2022",
        "flavour" : "Azure"
      }
      hardening_script_url = "https://stjtmgmtshrdvmimgwus2001.blob.core.windows.net/scripts/windows-server-hardening.ps1"
    }
  ]
  tags = merge(local.tags, { workload-name = "images" })
}
