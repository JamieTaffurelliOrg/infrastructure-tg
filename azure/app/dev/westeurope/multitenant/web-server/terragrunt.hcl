terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-windowsvm-tf///?ref=0.0.16"
}

include {
  path = find_in_parent_folders()
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "5284e392-c44d-444a-bf2e-07452a860241"

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

provider "azurerm" {
  alias = "images"
  subscription_id = "3bdf403f-77ac-4879-8fba-fa41c2cc94ee"

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

  resource_group_name = "rg-app-dev-web-weu1-001"
  location            = "westeurope"
  windows_virtual_machines = [
    {
      name                           = "vmappdvwebweu11"
      subnet_reference               = "snet-web"
      enable_accelerated_networking  = false
      private_ip_address             = "10.192.2.8"
      backend_address_pool_reference = "web-backend-pool"
      size                           = "Standard_B2ms"
      admin_username                 = "servermonkey"
      zone                           = "1"
      image_reference                = "win-2022-server-azure"
      timezone                       = "GMT Standard Time"
      source_image = {
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "2022-datacenter-azure-edition"
      }
    }
  ]
  subnets = [
    {
      name                 = "snet-web"
      virtual_network_name = "vnet-app-dev-net-weu1-001"
      resource_group_name  = "rg-app-dev-net-weu1-001"
    }
  ]
  load_balancers = [
    {
      name                = "lbi-app-dev-lb-weu1-001"
      resource_group_name = "rg-app-dev-lb-weu1-001"
    }
  ]
  backend_address_pools = [
    {
      name                    = "web-backend-pool"
      load_balancer_reference = "lbi-app-dev-lb-weu1-001"
    }
  ]
  password_key_vault_name                = "kv-app-dev-kv-weu1-001"
  password_key_vault_resource_group_name = "rg-app-dev-kv-weu1-001"
  /*shared_images = [
    {
      name                                     = "win-2022-server-azure"
      shared_image_gallery_name                = "galmgmtshrdvmimgweu1001"
      shared_image_gallery_resource_group_name = "rg-mgmt-shrd-vmimg-weu1-001"
    }
  ]*/
  log_analytics_workspace_name                = "log-mgmt-dev-log-weu1-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-dev-log-weu1-001"
  storage_account_name                        = "stjtappdevdiagweu1001"
  storage_account_resource_group_name         = "rg-app-dev-diag-weu1-001"
  tags                                        = merge(local.tags, { workload-name = "web" })
}
