terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-redis-tf///?ref=0.0.4"
}

include {
  path = find_in_parent_folders()
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

provider "azurerm" {
  alias = "dns"
  subscription_id = "3d6c3571-dbcd-47fa-a4f1-f2993adb6c90"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
EOF

}

inputs = {

  resource_group_name = "rg-app-dev-redis-weu1-001"
  location            = "westeurope"
  redis_cache_name    = "redis-app-dev-redis-weu1-001"
  capacity            = 0
  family              = "C"
  sku_name            = "Basic"
  day_of_week         = "Friday"
  start_hour_utc      = 23
  redis_firewall_rules = [
    {
      name     = "test"
      start_ip = "0.0.0.0"
      end_ip   = "255.255.255.255"
    }
  ]
  subnet_name                = "snet-redis"
  virtual_network_name       = "vnet-app-dev-net-weu1-001"
  subnet_resource_group_name = "rg-app-dev-net-weu1-001"
  private_dns_zones = [
    {
      name                = "privatelink.redis.cache.windows.net"
      resource_group_name = "rg-conn-dev-prvdns-weu1-001"
    }
  ]
  log_analytics_workspace_name                = "log-mgmt-dev-log-weu1-001"
  log_analytics_workspace_resource_group_name = "rg-mgmt-dev-log-weu1-001"
  tags                                        = merge(local.tags, { workload-name = "redis" })
}
