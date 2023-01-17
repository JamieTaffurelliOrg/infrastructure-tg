terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-windowsvm-tf///?ref=0.0.4"
}

include {
  path = find_in_parent_folders()
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "e1806152-a836-4eed-b591-d76f6267b6d2"

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
    stack               = "app"
  }
}

inputs = {

  resource_group_name = "rg-app-dev-web-wus2-001"
  location            = "westus2"
  windows_virtual_machines = [
    {
      name               = "vmappdvwebwus21"
      subnet_reference   = "snet-web"
      private_ip_address = "10.192.2.4"
      size               = "Standard_B2ms"
      admin_username     = "servermonkey"
      zone               = "1"
      image_reference    = "win-2022-server-azure"
      timezone           = "GMT"
    }
  ]
  subnets = [
    {
      name                 = "snet-web"
      virtual_network_name = "vnet-app-dev-net-wus2-001"
      resource_group_name  = "rg-app-dev-net-wus2-001"
    }
  ]
  password_key_vault_name                = "kv-app-dev-kv-wus2-001"
  password_key_vault_resource_group_name = "rg-app-dev-kv-wus2-001"
  shared_images = [
    {
      name                                     = "win-2022-server-azure"
      shared_image_gallery_name                = "galmgmtshrdvmimgwus2001"
      shared_image_gallery_resource_group_name = "rg-mgmt-shrd-vmimg-wus2-001"
    }
  ]
  log_analytics_workspace_name                = "log-mgmt-dev-log-wus2-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-dev-log-wus2-001"
  storage_account_name                        = "stjtmgmtdevlogwus2001"
  storage_account_resource_group_name         = "rg-mgmt-dev-log-wus2-001"
  tags                                        = merge(local.tags, { workload-name = "network" })
}
