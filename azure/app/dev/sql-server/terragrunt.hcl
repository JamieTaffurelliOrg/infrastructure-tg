terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-windowsvm-tf///?ref=0.0.10"
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

provider "azurerm" {
  alias = "images"
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
    environment         = "dev"
    stack               = "app"
  }
}

inputs = {

  resource_group_name = "rg-app-dev-sql-weu1-001"
  location            = "westeurope"
  windows_virtual_machines = [
    {
      name                          = "vmappdvsqlweu11"
      subnet_reference              = "snet-sql"
      enable_accelerated_networking = false
      private_ip_address            = "10.192.3.8"
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
      virtual_network_name = "vnet-app-dev-net-weu1-001"
      resource_group_name  = "rg-app-dev-net-weu1-001"
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
  tags                                        = merge(local.tags, { workload-name = "sql" })
}
