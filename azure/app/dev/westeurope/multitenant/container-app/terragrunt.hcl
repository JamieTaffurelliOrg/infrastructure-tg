terraform {
  //source = "git::https://github.com/JamieTaffurelliOrg/az-containerapp-tf///?ref=0.0.4"
  source = "../../../../../../../az-containerapp-tf"
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

provider "azapi" {
  subscription_id = "5284e392-c44d-444a-bf2e-07452a860241"
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

  container_app_environment_name                = "cae-app-dev-cae-weu1-001"
  container_app_environment_resource_group_name = "rg-app-dev-cae-weu1-001"
  resource_group_name                           = "rg-app-dev-ca-weu1-001"
  container_apps = [
    {
      name = "ca-app-dev-ca-weu1-001"
      ingress = {
        allow_insecure_connections = true
        exposed_port               = 80
        target_port                = 80
      }
      containers = [
        {
          name   = "test"
          image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
          cpu    = "0.5"
          memory = "250Mb"
        }
      ]
      scale = {
        max_replicas = 1
        min_replicas = 0
      }
    }
  ]
  tags = merge(local.tags, { workload = "container-app" })
}
