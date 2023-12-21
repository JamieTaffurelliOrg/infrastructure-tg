terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-identity-tf///?ref=0.1.33"
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
  lz_environment_hyphen = "app-prod"
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
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.prod.waf.deploy"
    }
    "${local.lz_environment_hyphen}-net-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-net-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.prod.network.deploy"
    }
    "${local.lz_environment_hyphen}-lb-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-lb-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.prod.load-balancer.deploy"
    }
    "${local.lz_environment_hyphen}-web-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-web-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.prod.web-server.deploy"
    }
    "${local.lz_environment_hyphen}-sql-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-sql-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.prod.sql-server.deploy"
    }
    "${local.lz_environment_hyphen}-kv-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-kv-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.prod.key-vault.deploy"
    }
    "${local.lz_environment_hyphen}-redis-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-redis-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.prod.redis.deploy"
    }
    "${local.lz_environment_hyphen}-aci-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-aci-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.prod.aci.deploy"
    }
    "${local.lz_environment_hyphen}-agw-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-agw-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.prod.app-gateway.deploy"
    }
    "${local.lz_environment_hyphen}-cae-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-cae-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.prod.container-app-environment.deploy"
    }
  }
  service_principals = {
    "${local.lz_environment_hyphen}-waf-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-waf-tf"
      description              = "Management of prod App Gateway WAF via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-waf-tf"]
    }
    "${local.lz_environment_hyphen}-net-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-net-tf"
      description              = "Management of prod app network infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-net-tf"]
    }
    "${local.lz_environment_hyphen}-lb-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-lb-tf"
      description              = "Management of prod app load balancer infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-lb-tf"]
    }
    "${local.lz_environment_hyphen}-web-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-web-tf"
      description              = "Management of prod app web server infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-web-tf"]
    }
    "${local.lz_environment_hyphen}-sql-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-sql-tf"
      description              = "Management of prod app sql server infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-sql-tf"]
    }
    "${local.lz_environment_hyphen}-kv-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-kv-tf"
      description              = "Management of prod app key vault infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-kv-tf"]
    }
    "${local.lz_environment_hyphen}-redis-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-redis-tf"
      description              = "Management of prod app redis infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-redis-tf"]
    }
    "${local.lz_environment_hyphen}-aci-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-aci-tf"
      description              = "Management of prod app container instance infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-aci-tf"]
    }
    "${local.lz_environment_hyphen}-agw-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-agw-tf"
      description              = "Management of prod app gateway infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-agw-tf"]
    }
    "${local.lz_environment_hyphen}-cae-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-cae-tf"
      description              = "Management of prod app container app environment infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-cae-tf"]
    }
  }
  rbac_role_assignments_service_principals = {
    "${local.lz_environment_hyphen}-waf-tf-blobcontributor-appprodcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-waf-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappprodtfweu1001/blobServices/default/containers/app-prod"
    }
    "${local.lz_environment_hyphen}-waf-tf-contributor-appprodwaf" = {
      service_principal_reference = "${local.lz_environment_hyphen}-waf-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-waf-weu1-001"
    }
    "${local.lz_environment_hyphen}-net-tf-contributor-appprodnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-net-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-net-weu1-001"
    }
    "${local.lz_environment_hyphen}-net-tf-blobcontributor-appprodcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-net-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappprodtfweu1001/blobServices/default/containers/app-prod"
    }
    "${local.lz_environment_hyphen}-net-tf-prvdnscontributor-connprodprvdns" = {
      service_principal_reference = "${local.lz_environment_hyphen}-net-tf"
      role_definition_name        = "Private DNS Zone Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-prvdns-weu1-001"
    }
    "${local.lz_environment_hyphen}-net-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-net-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_prod_subscription_id}/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-net-tf-netcontributor-appprodnetwatcher" = {
      service_principal_reference = "${local.lz_environment_hyphen}-net-tf"
      role_definition_name        = "Network Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-netwat-weu1-001/providers/Microsoft.Network/networkWatchers/nw-app-prod-netwat-weu1-001"
    }
    "${local.lz_environment_hyphen}-net-tf-reader-appprodsub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-net-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}"
    }
    "${local.lz_environment_hyphen}-net-tf-contributor-mgmtprodlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-net-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_prod_subscription_id}/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtprodlogweu1001"
    }
    "${local.lz_environment_hyphen}-net-tf-contributor-appprodpip" = {
      service_principal_reference = "${local.lz_environment_hyphen}-net-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-pip-weu1-001"
    }
    "${local.lz_environment_hyphen}-lb-tf-contributor-appprodlb" = {
      service_principal_reference = "${local.lz_environment_hyphen}-lb-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-lb-weu1-001"
    }
    "${local.lz_environment_hyphen}-lb-tf-blobcontributor-appprodcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-lb-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappprodtfweu1001/blobServices/default/containers/app-prod"
    }
    "${local.lz_environment_hyphen}-lb-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-lb-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_prod_subscription_id}/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-web-tf-contributor-appprodweb" = {
      service_principal_reference = "${local.lz_environment_hyphen}-web-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-web-weu1-001"
    }
    "${local.lz_environment_hyphen}-web-tf-blobcontributor-appprodcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-web-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappprodtfweu1001/blobServices/default/containers/app-prod"
    }
    "${local.lz_environment_hyphen}-web-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-web-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_prod_subscription_id}/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-web-tf-reader-mgmtshrdimg" = {
      service_principal_reference = "${local.lz_environment_hyphen}-web-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_shrd_subscription_id}/resourceGroups/rg-mgmt-shrd-vmimg-weu1-001"
    }
    "${local.lz_environment_hyphen}-web-tf-kvadmin-appprodkv" = {
      service_principal_reference = "${local.lz_environment_hyphen}-web-tf"
      role_definition_name        = "Key Vault Administrator"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-kv-weu1-001/providers/Microsoft.KeyVault/vaults/kv-app-prod-kv-weu1-001"
    }
    "${local.lz_environment_hyphen}-web-tf-reader-appprodlb" = {
      service_principal_reference = "${local.lz_environment_hyphen}-web-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-lb-weu1-001"
    }
    "${local.lz_environment_hyphen}-sql-tf-contributor-appprodsql" = {
      service_principal_reference = "${local.lz_environment_hyphen}-sql-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-sql-weu1-001"
    }
    "${local.lz_environment_hyphen}-sql-tf-blobcontributor-appprodcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-sql-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappprodtfweu1001/blobServices/default/containers/app-prod"
    }
    "${local.lz_environment_hyphen}-sql-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-sql-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_prod_subscription_id}/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-sql-tf-reader-mgmtshrdimg" = {
      service_principal_reference = "${local.lz_environment_hyphen}-sql-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_shrd_subscription_id}/resourceGroups/rg-mgmt-shrd-vmimg-weu1-001"
    }
    "${local.lz_environment_hyphen}-sql-tf-kvadmin-appprodkv" = {
      service_principal_reference = "${local.lz_environment_hyphen}-sql-tf"
      role_definition_name        = "Key Vault Administrator"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-kv-weu1-001/providers/Microsoft.KeyVault/vaults/kv-app-prod-kv-weu1-001"
    }
    "${local.lz_environment_hyphen}-kv-tf-contributor-appprodkv" = {
      service_principal_reference = "${local.lz_environment_hyphen}-kv-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-kv-weu1-001"
    }
    "${local.lz_environment_hyphen}-kv-tf-blobcontributor-appprodcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-kv-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappprodtfweu1001/blobServices/default/containers/app-prod-kv"
    }
    "${local.lz_environment_hyphen}-kv-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-kv-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_prod_subscription_id}/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-redis-tf-contributor-appprodredis" = {
      service_principal_reference = "${local.lz_environment_hyphen}-redis-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-redis-weu1-001"
    }
    "${local.lz_environment_hyphen}-redis-tf-blobcontributor-appprodcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-redis-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappprodtfweu1001/blobServices/default/containers/app-prod"
    }
    "${local.lz_environment_hyphen}-redis-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-redis-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_prod_subscription_id}/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-redis-tf-prvdnscontributor-connprodprvdns" = {
      service_principal_reference = "${local.lz_environment_hyphen}-redis-tf"
      role_definition_name        = "Private DNS Zone Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-prvdns-weu1-001"
    }
    "${local.lz_environment_hyphen}-aci-tf-contributor-appprodaci" = {
      service_principal_reference = "${local.lz_environment_hyphen}-aci-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-aci-weu1-001"
    }
    "${local.lz_environment_hyphen}-aci-tf-blobcontributor-appprodcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-aci-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappprodtfweu1001/blobServices/default/containers/app-prod"
    }
    "${local.lz_environment_hyphen}-aci-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-aci-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_prod_subscription_id}/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-agw-tf-contributor-appprodagw" = {
      service_principal_reference = "${local.lz_environment_hyphen}-agw-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-agw-weu1-001"
    }
    "${local.lz_environment_hyphen}-agw-tf-blobcontributor-appprodcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-agw-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappprodtfweu1001/blobServices/default/containers/app-prod"
    }
    "${local.lz_environment_hyphen}-agw-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-agw-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_prod_subscription_id}/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-agw-tf-reader-appprodwaf" = {
      service_principal_reference = "${local.lz_environment_hyphen}-agw-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-waf-weu1-001"
    }
    "${local.lz_environment_hyphen}-agw-tf-reader-appprodnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-agw-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-net-weu1-001"
    }
    "${local.lz_environment_hyphen}-agw-tf-reader-appprodpip" = {
      service_principal_reference = "${local.lz_environment_hyphen}-agw-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-pip-weu1-001"
    }
    "${local.lz_environment_hyphen}-cae-tf-contributor-appprodcae" = {
      service_principal_reference = "${local.lz_environment_hyphen}-cae-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-cae-weu1-001"
    }
    "${local.lz_environment_hyphen}-cae-tf-blobcontributor-appprodcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-cae-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappprodtfweu1001/blobServices/default/containers/app-prod"
    }
    "${local.lz_environment_hyphen}-cae-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-cae-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_prod_subscription_id}/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-kv-tf-contributor-appprodkv" = {
      service_principal_reference = "${local.lz_environment_hyphen}-kv-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/e1806152-a836-4eed-b591-d76f6267b6d2/resourceGroups/rg-app-prod-kv-wus2-001"
    }
    "${local.lz_environment_hyphen}-kv-tf-blobcontributor-appprodcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-kv-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/e1806152-a836-4eed-b591-d76f6267b6d2/resourceGroups/rg-app-prod-tf-frc1-001/providers/Microsoft.Storage/storageAccounts/stjtappprodtffrc1001/blobServices/default/containers/app-prod-kv"
    }
    "${local.lz_environment_hyphen}-kv-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-kv-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/4593b317-03e9-4533-9f41-e0d4b6da338c/resourceGroups/rg-mgmt-prod-log-wus2-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-wus2-001"
    }
  }
  custom_rbac_role_assignments_service_principals = {
    "${local.lz_environment_hyphen}-net-tf-vnetpeer-appprodnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-net-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Virtual Network Peerer (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-hub-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-conn-prod-hub-weu1-001"
    }
    "${local.lz_environment_hyphen}-net-tf-vhubjoin-connprodvhub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-net-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Virtual Hub Joiner (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-vhub-weu1-001/providers/Microsoft.Network/virtualHubs/vhub-conn-prod-vhub-weu1-001"
    }
    "${local.lz_environment_hyphen}-lb-tf-subnetjoin-appprodnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-lb-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Subnet Joiner (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-net-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-app-prod-net-weu1-001"
    }
    "${local.lz_environment_hyphen}-web-tf-subnetjoin-appprodnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-web-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Subnet Joiner (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-net-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-app-prod-net-weu1-001/subnets/snet-web"
    }
    /*"${local.lz_environment_hyphen}-web-tf-lbjoin-appprodlb" = {
      service_principal_reference = "${local.lz_environment_hyphen}-web-tf"
      custom_role_id       = dependency.parent.outputs.rbac_role_definitions["Load Balancer Backend Address Pool Joiner (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-lb-weu1-001/providers/Microsoft.Network/loadBalancers/lbi-app-prod-lb-weu1-001/backendAddressPools/web-backend-pool"
    }*/
    "${local.lz_environment_hyphen}-sql-tf-subnetjoin-appprodnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-sql-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Subnet Joiner (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-net-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-app-prod-net-weu1-001/subnets/snet-sql"
    }
    "${local.lz_environment_hyphen}-sql-tf-sqlreg-appprod" = {
      service_principal_reference = "${local.lz_environment_hyphen}-sql-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["SQL VM Register (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}"
    }
    "${local.lz_environment_hyphen}-redis-tf-subnetjoin-appprodnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-redis-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Subnet Joiner (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-net-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-app-prod-net-weu1-001/subnets/snet-redis"
    }
    "${local.lz_environment_hyphen}-aci-tf-subnetjoin-appprodnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-aci-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Subnet Joiner (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-net-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-app-prod-net-weu1-001/subnets/snet-aci"
    }
    "${local.lz_environment_hyphen}-agw-tf-subnetjoin-appprodnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-agw-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Subnet Joiner (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-net-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-app-prod-net-weu1-001/subnets/snet-appgw"
    }
    "${local.lz_environment_hyphen}-agw-tf-prefixjoin-appprodpipprefix" = {
      service_principal_reference = "${local.lz_environment_hyphen}-agw-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Public IP Prefix Joiner (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-pip-weu1-001/providers/Microsoft.Network/publicIPPrefixes/ippre-app-prod-pip-weu1-001"
    }
    "${local.lz_environment_hyphen}-cae-tf-subnetjoin-appprodnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-cae-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Subnet Joiner (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-net-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-app-prod-net-weu1-001/subnets/snet-cae"
    }
    "${local.lz_environment_hyphen}-cae-tf-appreg-appprod" = {
      service_principal_reference = "${local.lz_environment_hyphen}-cae-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["App Register (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}"
    }
  }
}
