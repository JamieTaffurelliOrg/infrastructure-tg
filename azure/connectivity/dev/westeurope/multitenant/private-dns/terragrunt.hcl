terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-privatedns-tf///?ref=0.0.12"
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
  subscription_id = "${include.azure.locals.conn_dev_subscription_id}"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
EOF

}

locals {
  tags                  = merge(include.azure.locals.default_tags, include.landing_zone.locals.default_tags, include.environment.locals.default_tags, { workload = "private-dns" })
  org_prefix            = include.azure.locals.org_prefix
  lz_environment_hyphen = "${include.landing_zone.locals.landing_zone_name}-${include.environment.locals.environment_name}"
  lz_environment_concat = "${include.landing_zone.locals.landing_zone_name}${include.environment.locals.environment_name}"
  location_short        = include.region.locals.region_short
  location              = include.region.locals.region_full
}

inputs = {

  resource_group_name = "rg-${local.lz_environment_hyphen}-prvdns-${local.location_short}-001"
  private_dns_zones = [
    {
      name = "privatelink.azure-automation.net"
    },
    {
      name = "privatelink.redis.cache.windows.net"
    },
    {
      name = "privatelink.database.windows.net"
    },
    {
      name = "privatelink.blob.core.windows.net"
    },
    {
      name = "privatelink.table.core.windows.net"
    },
    {
      name = "privatelink.queue.core.windows.net"
    },
    {
      name = "privatelink.file.core.windows.net"
    },
    {
      name = "privatelink.web.core.windows.net"
    },
    {
      name = "privatelink.batch.azure.com"
    },
    {
      name = "privatelink.vaultcore.azure.net"
    },
    {
      name = "${local.location_short}.internal.jamietaffurellidev.com"
    }
  ]
  tags = local.tags
}
