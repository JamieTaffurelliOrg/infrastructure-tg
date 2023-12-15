terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-linuxwebapp-tf///?ref=0.0.2"
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

  web_app_name                     = "app-${local.lz_environment_hyphen}-web-${local.location_short}-001"
  resource_group_name              = "rg-${local.lz_environment_hyphen}-web-${local.location_short}-001"
  service_plan_name                = "asp-${local.lz_environment_hyphen}-ase-${local.location_short}-001"
  service_plan_resource_group_name = "rg-${local.lz_environment_hyphen}-ase-${local.location_short}-001"
  auto_heal_enabled                = false
  health_check_path                = null
  auto_heal_setting = {
    minimum_process_execution_time = "01:00:00"
    requests = [
      {
        count    = 10
        interval = "01:00:00"
      }
    ]
  }
  sas_urls = {
    "logging-sas" : get_env("AZ_SAS")
  }
  logs = {
    application_logs = {
      azure_blob_storage = {
        sas_url_reference = "logging-sas"
      }
    }
    http_logs = {
      azure_blob_storage_http = {
        sas_url_reference = "logging-sas"
      }
    }
  }
  application_stack = {
    dotnet_version = "7.0"
  }
  log_analytics_workspace_name                = "log-mgmt-${include.environment.environment_name}-log-${local.location_short}-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-${include.environment.environment_name}-log-${local.location_short}-001"
  tags                                        = local.tags
}
