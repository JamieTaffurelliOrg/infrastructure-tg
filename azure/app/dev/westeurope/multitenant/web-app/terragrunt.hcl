terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-linuxwebapp-tf///?ref=0.0.2"
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

  web_app_name                     = "app-app-dev-web-weu1-001"
  resource_group_name              = "rg-app-dev-web-weu1-001"
  service_plan_name                = "asp-app-dev-ase-weu1-001"
  service_plan_resource_group_name = "rg-app-dev-ase-weu1-001"
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
  log_analytics_workspace_name                = "log-mgmt-dev-log-weu1-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-dev-log-weu1-001"
  tags                                        = merge(local.tags, { workload = "web" })
}
