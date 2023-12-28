terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-windowsvm-tf///?ref=0.0.24"
}

include "azure" {
  path   = find_in_parent_folders("azure.hcl")
  expose = true
}

include "landing_zone" {
  path   = find_in_parent_folders("landing_zone.hcl")
  expose = true
}

include "environment" {
  path   = find_in_parent_folders("environment.hcl")
  expose = true
}

include "region" {
  path   = find_in_parent_folders("region.hcl")
  expose = true
}

include "tenant" {
  path   = find_in_parent_folders("tenant.hcl")
  expose = true
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "${include.azure.locals.app_dev_subscription_id}"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
  subscription_id = "${include.azure.locals.mgmt_dev_subscription_id}"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "images"
  subscription_id = "${include.azure.locals.mgmt_shrd_subscription_id}"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
EOF

}

locals {
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { workload = "web" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.locals.landing_zone_name}-${include.environment.locals.environment_name}"
  lz_environment_concat = "${include.landing_zone.locals.landing_zone_name}${include.environment.locals.environment_name}"
  location_short        = include.region.locals.region_short
  location              = include.region.locals.region_full
}

inputs = {

  resource_group_name = "rg-${local.lz_environment_hyphen}-web-${local.location_short}-001"
  location            = local.location
  windows_virtual_machines = [
    {
      name                           = "vmappdvweb${local.location_short}1"
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
      virtual_network_name = "vnet-${local.lz_environment_hyphen}-net-${local.location_short}-001"
      resource_group_name  = "rg-${local.lz_environment_hyphen}-net-${local.location_short}-001"
    }
  ]
  load_balancers = [
    {
      name                = "lbi-${local.lz_environment_hyphen}-lb-${local.location_short}-001"
      resource_group_name = "rg-${local.lz_environment_hyphen}-lb-${local.location_short}-001"
    }
  ]
  backend_address_pools = [
    {
      name                    = "web-backend-pool"
      load_balancer_reference = "lbi-${local.lz_environment_hyphen}-lb-${local.location_short}-001"
    }
  ]
  password_key_vault_name                = "kv-${local.lz_environment_hyphen}-kv-${local.location_short}-001"
  password_key_vault_resource_group_name = "rg-${local.lz_environment_hyphen}-kv-${local.location_short}-001"
  /*shared_images = [
    {
      name                                     = "win-2022-server-azure"
      shared_image_gallery_name                = "galmgmtshrdvmimg${local.location_short}001"
      shared_image_gallery_resource_group_name = "rg-mgmt-shrd-vmimg-${local.location_short}-001"
    }
  ]*/
  log_analytics_workspace_name                = "log-mgmt-${include.environment.locals.environment_name}-log-${local.location_short}-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-${include.environment.locals.environment_name}-log-${local.location_short}-001"
  storage_account_name                        = "st${local.org_prefix}${local.lz_environment_concat}diag${local.location_short}001"
  storage_account_resource_group_name         = "rg-${local.lz_environment_hyphen}-diag-${local.location_short}-001"
  tags                                        = local.tags
}
