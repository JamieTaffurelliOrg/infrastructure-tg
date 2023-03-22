terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-redis-tf///?ref=0.0.2"
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
  alias = "dns"
  subscription_id = "58b4ad6f-a160-4b9e-841b-e177f66137c9"

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
