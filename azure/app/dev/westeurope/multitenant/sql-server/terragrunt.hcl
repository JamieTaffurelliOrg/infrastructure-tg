terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-windowsvm-tf///?ref=0.0.18"
}

include "azure" {
  path = find_in_parent_folders("azure.hcl")
}

include "landing_zone" {
  path = find_in_parent_folders("landing_zone.hcl")
}

include "environment" {
  path = find_in_parent_folders("environment.hcl")
}

include "region" {
  path = find_in_parent_folders("region.hcl")
}

include "tenant" {
  path = find_in_parent_folders("tenant.hcl")
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azurerm" {
  subscription_id = ${include.azure.locals.app_dev_subscription_id}

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
  subscription_id = ${include.azure.locals.mgmt_dev_subscription_id}

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "images"
  ${include.azure.locals.mgmt_shrd_subscription_id}

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
EOF

}

locals {
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { workload = "sql" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.landing_zone_name}-${include.environment.environment_name}"
  lz_environment_concat = "${include.landing_zone.landing_zone_name}${include.environment.environment_name}"
  location_short        = include.region.region_short
  location              = include.region.region_full
}

inputs = {

  resource_group_name = "rg-${local.lz_environment_hyphen}-sql-${local.location_short}-001"
  location            = local.location
  windows_virtual_machines = [
    {
      name                          = "vmappdvsql${local.location_short}1"
      subnet_reference              = "snet-sql"
      enable_accelerated_networking = false
      private_ip_address            = "10.192.3.8"
      size                          = "Standard_B2ms"
      admin_username                = "servermonkey"
      zone                          = "3"
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
      virtual_network_name = "vnet-${local.lz_environment_hyphen}-net-${local.location_short}-001"
      resource_group_name  = "rg-${local.lz_environment_hyphen}-net-${local.location_short}-001"
    }
  ]
  password_key_vault_name                = "kv-${local.lz_environment_hyphen}-kv-${local.location_short}-002"
  password_key_vault_resource_group_name = "rg-${local.lz_environment_hyphen}-kv-${local.location_short}-001"
  /*shared_images = [
    {
      name                                     = "win-2022-server-azure"
      shared_image_gallery_name                = "galmgmtshrdvmimg${local.location_short}001"
      shared_image_gallery_resource_group_name = "rg-mgmt-shrd-vmimg-${local.location_short}-001"
    }
  ]*/
  log_analytics_workspace_name                = "log-mgmt-${include.environment.environment_name}-log-${local.location_short}-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-${include.environment.environment_name}-log-${local.location_short}-001"
  storage_account_name                        = "st${local.org_prefix}${local.lz_environment_concat}diag${local.location_short}002"
  storage_account_resource_group_name         = "rg-${local.lz_environment_hyphen}-diag-${local.location_short}-001"
  tags                                        = local.tags
}
