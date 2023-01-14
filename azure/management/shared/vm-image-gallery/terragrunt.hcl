terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-vmimagegallery-tf///?ref=0.0.2"
}

remote_state {

  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    resource_group_name  = "rg-mgmt-shrd-tf-frc1-001"
    storage_account_name = "stjtmgmtshrdtffrc1001"
    container_name       = "mgmt-shrd"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    use_azuread_auth     = true
  }
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "a9da0406-a642-49b3-9c2c-c8ed05bb1c85"

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

  resource_group_name       = "rg-mgmt-shrd-vmimg-wus2-001"
  location                  = "westus2"
  image_gallery_name        = "gal-mgmt-shrd-vmimg-wus2-001"
  image_gallery_description = "Store and share compliant VM images for deployment of VMs"
  images = [
    {
      names       = "win-2022-server-azure"
      os_type     = "Windows"
      description = "Base windows 2022 server"
      publisher   = "MicrosoftWindowsServer"
      offer       = "WindowsServer"
      sku         = "2022-datacenter-azure-edition"
    }
  ]
  storage_account_name = "stjtmgmtprodlogwus2001"
  tags                 = merge(local.tags, { workload-name = "images" })
}
