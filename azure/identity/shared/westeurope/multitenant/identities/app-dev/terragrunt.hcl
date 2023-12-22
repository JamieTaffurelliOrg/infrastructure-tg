terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-identity-tf///?ref=0.1.35"
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

dependency "parent" {
  config_path = ".."
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azuread" {
}

provider "azurerm" {
  subscription_id = "${include.azure.locals.iden_shrd_subscription_id}"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
  subscription_id = "${include.azure.locals.mgmt_prod_subscription_id}"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
EOF

}

locals {
  lz_environment_hyphen = "app-dev"
}

inputs = {
  applications = {
    "${local.lz_environment_hyphen}-waf-tf" = {
      display_name = "${local.lz_environment_hyphen}-waf-tf"
      tags         = ["${local.lz_environment_hyphen}-waf-tf"]
    }
    "${local.lz_environment_hyphen}-net-tf" = {
      display_name = "${local.lz_environment_hyphen}-net-tf"
      tags         = ["${local.lz_environment_hyphen}-net-tf"]
    }
    "${local.lz_environment_hyphen}-lb-tf" = {
      display_name = "${local.lz_environment_hyphen}-lb-tf"
      tags         = ["${local.lz_environment_hyphen}-lb-tf"]
    }
    "${local.lz_environment_hyphen}-web-tf" = {
      display_name = "${local.lz_environment_hyphen}-web-tf"
      tags         = ["${local.lz_environment_hyphen}-web-tf"]
    }
    "${local.lz_environment_hyphen}-sql-tf" = {
      display_name = "${local.lz_environment_hyphen}-sql-tf"
      tags         = ["${local.lz_environment_hyphen}-sql-tf"]
    }
    "${local.lz_environment_hyphen}-kv-tf" = {
      display_name = "${local.lz_environment_hyphen}-kv-tf"
      tags         = ["${local.lz_environment_hyphen}-kv-tf"]
    }
    "${local.lz_environment_hyphen}-redis-tf" = {
      display_name = "${local.lz_environment_hyphen}-redis-tf"
      tags         = ["${local.lz_environment_hyphen}-redis-tf"]
    }
    "${local.lz_environment_hyphen}-aci-tf" = {
      display_name = "${local.lz_environment_hyphen}-aci-tf"
      tags         = ["${local.lz_environment_hyphen}-aci-tf"]
    }
    "${local.lz_environment_hyphen}-agw-tf" = {
      display_name = "${local.lz_environment_hyphen}-agw-tf"
      tags         = ["${local.lz_environment_hyphen}-agw-tf"]
    }
    "${local.lz_environment_hyphen}-cae-tf" = {
      display_name = "${local.lz_environment_hyphen}-cae-tf"
      tags         = ["${local.lz_environment_hyphen}-cae-tf"]
    }
  }
  application_federated_identity_credentials = {
    "${local.lz_environment_hyphen}-waf-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-waf-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.dev.waf.deploy"
    }
    "${local.lz_environment_hyphen}-net-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-net-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.dev.network.deploy"
    }
    "${local.lz_environment_hyphen}-lb-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-lb-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.dev.load-balancer.deploy"
    }
    "${local.lz_environment_hyphen}-web-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-web-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.dev.web-server.deploy"
    }
    "${local.lz_environment_hyphen}-sql-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-sql-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.dev.sql-server.deploy"
    }
    "${local.lz_environment_hyphen}-kv-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-kv-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.dev.key-vault.deploy"
    }
    "${local.lz_environment_hyphen}-redis-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-redis-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.dev.redis.deploy"
    }
    "${local.lz_environment_hyphen}-aci-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-aci-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.dev.aci.deploy"
    }
    "${local.lz_environment_hyphen}-agw-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-agw-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.dev.app-gateway.deploy"
    }
    "${local.lz_environment_hyphen}-cae-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-cae-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.dev.container-app-environment.deploy"
    }
  }
  service_principals = {
    "${local.lz_environment_hyphen}-waf-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-waf-tf"
      description              = "Management of dev App Gateway WAF via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-waf-tf"]
    }
    "${local.lz_environment_hyphen}-net-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-net-tf"
      description              = "Management of dev app network infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-net-tf"]
    }
    "${local.lz_environment_hyphen}-lb-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-lb-tf"
      description              = "Management of dev app load balancer infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-lb-tf"]
    }
    "${local.lz_environment_hyphen}-web-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-web-tf"
      description              = "Management of dev app web server infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-web-tf"]
    }
    "${local.lz_environment_hyphen}-sql-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-sql-tf"
      description              = "Management of dev app sql server infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-sql-tf"]
    }
    "${local.lz_environment_hyphen}-kv-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-kv-tf"
      description              = "Management of dev app key vault infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-kv-tf"]
    }
    "${local.lz_environment_hyphen}-redis-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-redis-tf"
      description              = "Management of dev app redis infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-redis-tf"]
    }
    "${local.lz_environment_hyphen}-aci-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-aci-tf"
      description              = "Management of dev app container instance infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-aci-tf"]
    }
    "${local.lz_environment_hyphen}-agw-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-agw-tf"
      description              = "Management of dev app gateway infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-agw-tf"]
    }
    "${local.lz_environment_hyphen}-cae-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-cae-tf"
      description              = "Management of dev app container app environment infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-cae-tf"]
    }
  }
  rbac_role_assignments_service_principals = {
    "${local.lz_environment_hyphen}-waf-tf-blobcontributor-appdevcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-waf-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappdevtfweu1001/blobServices/default/containers/app-dev"
    }
    "${local.lz_environment_hyphen}-waf-tf-contributor-appdevwaf" = {
      service_principal_reference = "${local.lz_environment_hyphen}-waf-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-waf-weu1-001"
    }
    "${local.lz_environment_hyphen}-net-tf-contributor-appdevnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-net-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-net-weu1-001"
    }
    "${local.lz_environment_hyphen}-net-tf-blobcontributor-appdevcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-net-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappdevtfweu1001/blobServices/default/containers/app-dev"
    }
    "${local.lz_environment_hyphen}-net-tf-prvdnscontributor-conndevprvdns" = {
      service_principal_reference = "${local.lz_environment_hyphen}-net-tf"
      role_definition_name        = "Private DNS Zone Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-prvdns-weu1-001"
    }
    "${local.lz_environment_hyphen}-net-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-net-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_dev_subscription_id}/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-net-tf-netcontributor-appdevnetwatcher" = {
      service_principal_reference = "${local.lz_environment_hyphen}-net-tf"
      role_definition_name        = "Network Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-netwat-weu1-001/providers/Microsoft.Network/networkWatchers/nw-app-dev-netwat-weu1-001"
    }
    "${local.lz_environment_hyphen}-net-tf-reader-appdevsub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-net-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}"
    }
    "${local.lz_environment_hyphen}-net-tf-contributor-mgmtdevlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-net-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_dev_subscription_id}/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtdevlogweu1001"
    }
    "${local.lz_environment_hyphen}-net-tf-contributor-appdevpip" = {
      service_principal_reference = "${local.lz_environment_hyphen}-net-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-pip-weu1-001"
    }
    "${local.lz_environment_hyphen}-lb-tf-contributor-appdevlb" = {
      service_principal_reference = "${local.lz_environment_hyphen}-lb-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-lb-weu1-001"
    }
    "${local.lz_environment_hyphen}-lb-tf-blobcontributor-appdevcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-lb-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappdevtfweu1001/blobServices/default/containers/app-dev"
    }
    "${local.lz_environment_hyphen}-lb-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-lb-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_dev_subscription_id}/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-web-tf-contributor-appdevweb" = {
      service_principal_reference = "${local.lz_environment_hyphen}-web-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-web-weu1-001"
    }
    "${local.lz_environment_hyphen}-web-tf-blobcontributor-appdevcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-web-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappdevtfweu1001/blobServices/default/containers/app-dev"
    }
    "${local.lz_environment_hyphen}-web-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-web-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_dev_subscription_id}/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-web-tf-reader-mgmtshrdimg" = {
      service_principal_reference = "${local.lz_environment_hyphen}-web-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_shrd_subscription_id}/resourceGroups/rg-mgmt-shrd-vmimg-weu1-001"
    }
    "${local.lz_environment_hyphen}-web-tf-kvadmin-appdevkv" = {
      service_principal_reference = "${local.lz_environment_hyphen}-web-tf"
      role_definition_name        = "Key Vault Administrator"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-kv-weu1-001/providers/Microsoft.KeyVault/vaults/kv-app-dev-kv-weu1-001"
    }
    "${local.lz_environment_hyphen}-web-tf-reader-appdevlb" = {
      service_principal_reference = "${local.lz_environment_hyphen}-web-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-lb-weu1-001"
    }
    "${local.lz_environment_hyphen}-sql-tf-contributor-appdevsql" = {
      service_principal_reference = "${local.lz_environment_hyphen}-sql-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-sql-weu1-001"
    }
    "${local.lz_environment_hyphen}-sql-tf-blobcontributor-appdevcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-sql-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappdevtfweu1001/blobServices/default/containers/app-dev"
    }
    "${local.lz_environment_hyphen}-sql-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-sql-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_dev_subscription_id}/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-sql-tf-reader-mgmtshrdimg" = {
      service_principal_reference = "${local.lz_environment_hyphen}-sql-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_shrd_subscription_id}/resourceGroups/rg-mgmt-shrd-vmimg-weu1-001"
    }
    "${local.lz_environment_hyphen}-sql-tf-kvadmin-appdevkv" = {
      service_principal_reference = "${local.lz_environment_hyphen}-sql-tf"
      role_definition_name        = "Key Vault Administrator"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-kv-weu1-001/providers/Microsoft.KeyVault/vaults/kv-app-dev-kv-weu1-001"
    }
    "${local.lz_environment_hyphen}-kv-tf-contributor-appdevkv" = {
      service_principal_reference = "${local.lz_environment_hyphen}-kv-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-kv-weu1-001"
    }
    "${local.lz_environment_hyphen}-kv-tf-blobcontributor-appdevcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-kv-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappdevtfweu1001/blobServices/default/containers/app-dev-kv"
    }
    "${local.lz_environment_hyphen}-kv-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-kv-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_dev_subscription_id}/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-kv-tf-reader-mgmtdevsub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-kv-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_dev_subscription_id}"
    }
    "${local.lz_environment_hyphen}-redis-tf-contributor-appdevredis" = {
      service_principal_reference = "${local.lz_environment_hyphen}-redis-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-redis-weu1-001"
    }
    "${local.lz_environment_hyphen}-redis-tf-blobcontributor-appdevcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-redis-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappdevtfweu1001/blobServices/default/containers/app-dev"
    }
    "${local.lz_environment_hyphen}-redis-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-redis-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_dev_subscription_id}/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-redis-tf-prvdnscontributor-conndevprvdns" = {
      service_principal_reference = "${local.lz_environment_hyphen}-redis-tf"
      role_definition_name        = "Private DNS Zone Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-prvdns-weu1-001"
    }
    "${local.lz_environment_hyphen}-aci-tf-contributor-appdevaci" = {
      service_principal_reference = "${local.lz_environment_hyphen}-aci-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-aci-weu1-001"
    }
    "${local.lz_environment_hyphen}-aci-tf-blobcontributor-appdevcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-aci-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappdevtfweu1001/blobServices/default/containers/app-dev"
    }
    "${local.lz_environment_hyphen}-aci-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-aci-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_dev_subscription_id}/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-agw-tf-contributor-appdevagw" = {
      service_principal_reference = "${local.lz_environment_hyphen}-agw-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-agw-weu1-001"
    }
    "${local.lz_environment_hyphen}-agw-tf-blobcontributor-appdevcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-agw-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappdevtfweu1001/blobServices/default/containers/app-dev"
    }
    "${local.lz_environment_hyphen}-agw-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-agw-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_dev_subscription_id}/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-agw-tf-reader-appdevwaf" = {
      service_principal_reference = "${local.lz_environment_hyphen}-agw-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-waf-weu1-001"
    }
    "${local.lz_environment_hyphen}-agw-tf-reader-appdevnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-agw-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-net-weu1-001"
    }
    "${local.lz_environment_hyphen}-agw-tf-reader-appdevpip" = {
      service_principal_reference = "${local.lz_environment_hyphen}-agw-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-pip-weu1-001"
    }
    "${local.lz_environment_hyphen}-cae-tf-contributor-appdevcae" = {
      service_principal_reference = "${local.lz_environment_hyphen}-cae-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-cae-weu1-001"
    }
    "${local.lz_environment_hyphen}-cae-tf-blobcontributor-appdevcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-cae-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappdevtfweu1001/blobServices/default/containers/app-dev"
    }
    "${local.lz_environment_hyphen}-cae-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-cae-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_dev_subscription_id}/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-kv-tf-contributor-appdevkv" = {
      service_principal_reference = "${local.lz_environment_hyphen}-kv-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-kv-weu1-001"
    }
    "${local.lz_environment_hyphen}-kv-tf-blobcontributor-appdevcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-kv-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappdevtfweu1001/blobServices/default/containers/app-dev-kv"
    }
    "${local.lz_environment_hyphen}-kv-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-kv-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_shrd_subscription_id}/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
  }
  custom_rbac_role_assignments_service_principals = {
    "${local.lz_environment_hyphen}-net-tf-vnetpeer-appdevnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-net-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Virtual Network Peerer (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-hub-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-conn-dev-hub-weu1-001"
    }
    "${local.lz_environment_hyphen}-net-tf-vhubjoin-conndevvhub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-net-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Virtual Hub Joiner (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-vhub-weu1-001/providers/Microsoft.Network/virtualHubs/vhub-conn-dev-vhub-weu1-001"
    }
    "${local.lz_environment_hyphen}-lb-tf-subnetjoin-appdevnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-lb-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Subnet Joiner (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-net-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-app-dev-net-weu1-001"
    }
    "${local.lz_environment_hyphen}-web-tf-subnetjoin-appdevnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-web-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Subnet Joiner (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-net-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-app-dev-net-weu1-001/subnets/snet-web"
    }
    /*"${local.lz_environment_hyphen}-web-tf-lbjoin-appdevlb" = {
      service_principal_reference = "${local.lz_environment_hyphen}-web-tf"
      custom_role_id       = dependency.parent.outputs.rbac_role_definitions["Load Balancer Backend Address Pool Joiner (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-lb-weu1-001/providers/Microsoft.Network/loadBalancers/lbi-app-dev-lb-weu1-001/backendAddressPools/web-backend-pool"
    }*/
    "${local.lz_environment_hyphen}-sql-tf-subnetjoin-appdevnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-sql-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Subnet Joiner (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-net-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-app-dev-net-weu1-001/subnets/snet-sql"
    }
    "${local.lz_environment_hyphen}-sql-tf-sqlreg-appdev" = {
      service_principal_reference = "${local.lz_environment_hyphen}-sql-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["SQL VM Register (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}"
    }
    "${local.lz_environment_hyphen}-redis-tf-subnetjoin-appdevnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-redis-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Subnet Joiner (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-net-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-app-dev-net-weu1-001/subnets/snet-privateendpoint"
    }
    "${local.lz_environment_hyphen}-aci-tf-subnetjoin-appdevnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-aci-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Subnet Joiner (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-net-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-app-dev-net-weu1-001/subnets/snet-aci"
    }
    "${local.lz_environment_hyphen}-agw-tf-subnetjoin-appdevnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-agw-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Subnet Joiner (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-net-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-app-dev-net-weu1-001/subnets/snet-appgw"
    }
    "${local.lz_environment_hyphen}-agw-tf-prefixjoin-appdevpipprefix" = {
      service_principal_reference = "${local.lz_environment_hyphen}-agw-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Public IP Prefix Joiner (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-pip-weu1-001/providers/Microsoft.Network/publicIPPrefixes/ippre-app-dev-pip-weu1-001"
    }
    "${local.lz_environment_hyphen}-cae-tf-subnetjoin-appdevnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-cae-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Subnet Joiner (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-net-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-app-dev-net-weu1-001/subnets/snet-cae"
    }
    "${local.lz_environment_hyphen}-cae-tf-appreg-appdev" = {
      service_principal_reference = "${local.lz_environment_hyphen}-cae-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["App Register (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}"
    }
    "${local.lz_environment_hyphen}-kv-tf-svcfabmshreg-appdevsub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-kv-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Service Fabric Mesh Register (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}"
    }
  }
}
