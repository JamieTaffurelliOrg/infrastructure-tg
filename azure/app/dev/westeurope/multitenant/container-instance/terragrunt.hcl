terraform {
  //source = "git::https://github.com/JamieTaffurelliOrg/az-aci-tf///?ref=0.0.3"
  source = "../../../../../../../az-aci-tf"
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

  container_group_name = "ci-app-dev-aci-weu1-001"
  resource_group_name  = "rg-app-dev-aci-weu1-001"
  location             = "westeurope"
  os_type              = "Windows"
  ip_address_type      = "Private"
  containers = [
    {
      name   = "hw"
      image  = "mcr.microsoft.com/windows/nanoserver:ltsc2022"
      cpu    = "0.5"
      memory = "1.5"
      ports = [
        {
          port = 80
        }
      ]
    }
  ]
  exposed_ports = [
    {
      port = 80
    }
  ]
  subnet_name                                 = "snet-aci"
  virtual_network_name                        = "vnet-app-dev-net-weu1-001"
  subnet_resource_group_name                  = "rg-app-dev-net-weu1-001"
  log_analytics_workspace_name                = "log-mgmt-dev-log-weu1-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-dev-log-weu1-001"
  tags                                        = merge(local.tags, { workload-name = "web" })
}
