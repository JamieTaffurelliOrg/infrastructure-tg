terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-containerapp-tf///?ref=0.0.5"
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

provider "azapi" {
  subscription_id = ${include.azure.locals.app_dev_subscription_id}
}
EOF

}

locals {
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { workload = "container-app" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.landing_zone_name}-${include.environment.environment_name}"
  lz_environment_concat = "${include.landing_zone.landing_zone_name}${include.environment.environment_name}"
  location_short        = include.region.region_short
  location              = include.region.region_full
}

inputs = {

  container_app_environment_name                = "cae-${local.lz_environment_hyphen}-cae-${local.location_short}-001"
  container_app_environment_resource_group_name = "rg-${local.lz_environment_hyphen}-cae-${local.location_short}-001"
  resource_group_name                           = "rg-${local.lz_environment_hyphen}-ca-${local.location_short}-001"
  container_apps = [
    {
      name = "ca-${local.lz_environment_hyphen}-ca-${local.location_short}-001"
      ingress = {
        allow_insecure_connections = true
        target_port                = 80
      }
      containers = [
        {
          name   = "test"
          image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
          cpu    = 0.25
          memory = "0.5Gi"
        }
      ]
      scale = {
        max_replicas = 1
        min_replicas = 1
      }
    }
  ]
  tags = merge(local.tags, { workload = "container-app" })
}
