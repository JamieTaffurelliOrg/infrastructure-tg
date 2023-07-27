terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-windowsvm-tf///?ref=0.0.17"
}

include {
  path = find_in_parent_folders()
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "f4722c2d-47d5-4513-a562-80465e3ee813"

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
    environment         = "prod"
    stack               = "app"
  }
}

inputs = {

  resource_group_name = "rg-app-prod-sql-weu1-001"
  location            = "westeurope"
  windows_virtual_machines = [
    {
      name                          = "vmappprsqlweu11"
      subnet_reference              = "snet-sql"
      enable_accelerated_networking = false
      private_ip_address            = "10.64.3.8"
      size                          = "Standard_B2ms"
      admin_username                = "servermonkey"
      zone                          = "1"
      image_reference               = "win-2022-server-azure"
      timezone                      = "GMT Standard Time"
      source_image = {
        publisher = "MicrosoftSQLServer"
        offer     = "sql2022-ws2022"
        sku       = "web-gen2"
      }
      disks = [
        {
          name         = "datadisk-1"
          disk_size_gb = 127
          lun          = 2
        },
        {
          name         = "logdisk-1"
          disk_size_gb = 127
          lun          = 3
        }
      ]
      sql = {
        data_file_path = "F:\\data"
        data_luns      = [2]
        log_file_path  = "G:\\data"
        log_luns       = [3]
      }
    }
  ]
  subnets = [
    {
      name                 = "snet-sql"
      virtual_network_name = "vnet-app-prod-net-weu1-001"
      resource_group_name  = "rg-app-prod-net-weu1-001"
    }
  ]
  password_key_vault_name                = "kv-app-prod-kv-weu1-001"
  password_key_vault_resource_group_name = "rg-app-prod-kv-weu1-001"
  /*shared_images = [
    {
      name                                     = "win-2022-server-azure"
      shared_image_gallery_name                = "galmgmtshrdvmimgweu1001"
      shared_image_gallery_resource_group_name = "rg-mgmt-shrd-vmimg-weu1-001"
    }
  ]*/
  log_analytics_workspace_name                = "log-mgmt-prod-log-weu1-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-prod-log-weu1-001"
  storage_account_name                        = "stjtappproddiagweu1002"
  storage_account_resource_group_name         = "rg-app-prod-diag-weu1-001"
  tags                                        = merge(local.tags, { workload = "sql" })
}
