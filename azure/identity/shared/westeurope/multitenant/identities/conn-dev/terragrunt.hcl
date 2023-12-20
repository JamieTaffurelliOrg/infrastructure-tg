terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-identity-tf///?ref=0.1.32"
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
  lz_environment_hyphen = "conn-dev"
}

inputs = {
  applications = {
    "${local.lz_environment_hyphen}-hub-tf" = {
      display_name = "${local.lz_environment_hyphen}-hub-tf"
      tags         = ["${local.lz_environment_hyphen}-hub-tf"]
    }
    "${local.lz_environment_hyphen}-prvdns-tf" = {
      display_name = "${local.lz_environment_hyphen}-prvdns-tf"
      tags         = ["${local.lz_environment_hyphen}-prvdns-tf"]
    }
    "${local.lz_environment_hyphen}-bas-tf" = {
      display_name = "${local.lz_environment_hyphen}-bas-tf"
      tags         = ["${local.lz_environment_hyphen}-bas-tf"]
    }
    "${local.lz_environment_hyphen}-afwp-tf" = {
      display_name = "${local.lz_environment_hyphen}-afwp-tf"
      tags         = ["${local.lz_environment_hyphen}-afwp-tf"]
    }
    "${local.lz_environment_hyphen}-afw-tf" = {
      display_name = "${local.lz_environment_hyphen}-afw-tf"
      tags         = ["${local.lz_environment_hyphen}-afw-tf"]
    }
    "${local.lz_environment_hyphen}-fdfp-tf" = {
      display_name = "${local.lz_environment_hyphen}-fdfp-tf"
      tags         = ["${local.lz_environment_hyphen}-fdfp-tf"]
    }
    "${local.lz_environment_hyphen}-afd-tf" = {
      display_name = "${local.lz_environment_hyphen}-afd-tf"
      tags         = ["${local.lz_environment_hyphen}-afd-tf"]
    }
    "${local.lz_environment_hyphen}-vwan-tf" = {
      display_name = "${local.lz_environment_hyphen}-vwan-tf"
      tags         = ["${local.lz_environment_hyphen}-vwan-tf"]
    }
    "${local.lz_environment_hyphen}-vhub-tf" = {
      display_name = "${local.lz_environment_hyphen}-vhub-tf"
      tags         = ["${local.lz_environment_hyphen}-vhub-tf"]
    }
    "${local.lz_environment_hyphen}-dnspr-tf" = {
      display_name = "${local.lz_environment_hyphen}-dnspr-tf"
      tags         = ["${local.lz_environment_hyphen}-dnspr-tf"]
    }
    "${local.lz_environment_hyphen}-pip-tf" = {
      display_name = "${local.lz_environment_hyphen}-pip-tf"
      tags         = ["${local.lz_environment_hyphen}-pip-tf"]
    }
  }
  application_federated_identity_credentials = {
    "${local.lz_environment_hyphen}-hub-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-hub-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.dev.hub-vnet.deploy"
    }
    "${local.lz_environment_hyphen}-prvdns-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-prvdns-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.dev.private-dns.deploy"
    }
    "${local.lz_environment_hyphen}-bas-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-bas-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.dev.bastion.deploy"
    }
    "${local.lz_environment_hyphen}-pip-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-pip-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.dev.public-ip.deploy"
    }
    "${local.lz_environment_hyphen}-afwp-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-afwp-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.dev.firewall-policy.deploy"
    }
    "${local.lz_environment_hyphen}-afw-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-afw-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.dev.firewall.deploy"
    }
    "${local.lz_environment_hyphen}-fdfp-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-fdfp-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.dev.front-door-waf-policy.deploy"
    }
    "${local.lz_environment_hyphen}-afd-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-afd-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.dev.front-door.deploy"
    }
    "${local.lz_environment_hyphen}-vwan-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-vwan-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.dev.virtual-wan.deploy"
    }
    "${local.lz_environment_hyphen}-vhub-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-vhub-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.dev.virtual-hub.deploy"
    }
    "${local.lz_environment_hyphen}-dnspr-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-dnspr-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.dev.dns-resolver.deploy"
    }
  }
  service_principals = {
    "${local.lz_environment_hyphen}-hub-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-hub-tf"
      description              = "Management of dev hub network infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-hub-tf"]
    }
    "${local.lz_environment_hyphen}-prvdns-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-prvdns-tf"
      description              = "Management of dev private DNS infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-prvdns-tf"]
    }
    "${local.lz_environment_hyphen}-bas-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-bas-tf"
      description              = "Management of dev Bastion infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-bas-tf"]
    }
    "${local.lz_environment_hyphen}-afwp-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-afwp-tf"
      description              = "Management of dev firewall policy infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-afwp-tf"]
    }
    "${local.lz_environment_hyphen}-afw-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-afw-tf"
      description              = "Management of dev firewall policy infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-afw-tf"]
    }
    "${local.lz_environment_hyphen}-fdfp-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-fdfp-tf"
      description              = "Management of dev front door waf policy infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-fdfp-tf"]
    }
    "${local.lz_environment_hyphen}-afd-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-afd-tf"
      description              = "Management of dev front door infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-afd-tf"]
    }
    "${local.lz_environment_hyphen}-vwan-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-vwan-tf"
      description              = "Management of dev virtual wan infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-vwan-tf"]
    }
    "${local.lz_environment_hyphen}-vhub-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-vhub-tf"
      description              = "Management of dev virtual hub infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-vhub-tf"]
    }
    "${local.lz_environment_hyphen}-dnspr-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-dnspr-tf"
      description              = "Management of dev dns resolver infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-dnspr-tf"]
    }
    "${local.lz_environment_hyphen}-pip-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-pip-tf"
      description              = "Management of dev public ip infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-pip-tf"]
    }
  }
  rbac_role_assignments_service_principals = {
    "${local.lz_environment_hyphen}-hub-tf-blobcontributor-conndevcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-hub-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconndevtfweu1001/blobServices/default/containers/conn-dev"
    }
    "${local.lz_environment_hyphen}-hub-tf-contributor-hubrg" = {
      service_principal_reference = "${local.lz_environment_hyphen}-hub-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-hub-weu1-001"
    }
    "${local.lz_environment_hyphen}-hub-tf-reader-sub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-hub-tf"
      role_definition_name        = "Reader"
      scope                       = "/providers/Microsoft.Subscription"
    }
    "${local.lz_environment_hyphen}-hub-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-hub-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_dev_subscription_id}/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-hub-tf-contributor-mgmtdevlogstorage" = {
      service_principal_reference = "${local.lz_environment_hyphen}-hub-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_dev_subscription_id}/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtdevlogweu1001"
    }
    "${local.lz_environment_hyphen}-hub-tf-netcontributor-conndevnetwatcher" = {
      service_principal_reference = "${local.lz_environment_hyphen}-hub-tf"
      role_definition_name        = "Network Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-netwat-weu1-001/providers/Microsoft.Network/networkWatchers/nw-conn-dev-netwat-weu1-001"
    }
    "${local.lz_environment_hyphen}-hub-tf-reader-conndevsub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-hub-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}"
    }
    "${local.lz_environment_hyphen}-hub-tf-reader-appdevsub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-hub-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}"
    }
    "${local.lz_environment_hyphen}-hub-tf-prvdnscontributor-conndevprvdns" = {
      service_principal_reference = "${local.lz_environment_hyphen}-hub-tf"
      role_definition_name        = "Private DNS Zone Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-prvdns-weu1-001"
    }
    "${local.lz_environment_hyphen}-prvdns-tf-contributor-conndevprvdns" = {
      service_principal_reference = "${local.lz_environment_hyphen}-prvdns-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-prvdns-weu1-001"
    }
    "${local.lz_environment_hyphen}-prvdns-tf-blobcontributor-conndevcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-prvdns-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconndevtfweu1001/blobServices/default/containers/conn-dev"
    }
    "${local.lz_environment_hyphen}-bas-tf-contributor-conndevbas" = {
      service_principal_reference = "${local.lz_environment_hyphen}-bas-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-bas-weu1-001"
    }
    "${local.lz_environment_hyphen}-bas-tf-blobcontributor-conndevcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-bas-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconndevtfweu1001/blobServices/default/containers/conn-dev"
    }
    "${local.lz_environment_hyphen}-bas-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-bas-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_dev_subscription_id}/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-bas-tf-reader-conndevvhub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-bas-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-vhub-weu1-001"
    }
    "${local.lz_environment_hyphen}-bas-tf-reader-conndevpip" = {
      service_principal_reference = "${local.lz_environment_hyphen}-bas-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-pip-weu1-001"
    }
    "${local.lz_environment_hyphen}-bas-tf-contributor-mgmtdevlogstorage" = {
      service_principal_reference = "${local.lz_environment_hyphen}-bas-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_dev_subscription_id}/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtdevlogweu1001"
    }
    "${local.lz_environment_hyphen}-bas-tf-netcontributor-conndevnetwatcher" = {
      service_principal_reference = "${local.lz_environment_hyphen}-bas-tf"
      role_definition_name        = "Network Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-netwat-weu1-001/providers/Microsoft.Network/networkWatchers/nw-conn-dev-netwat-weu1-001"
    }
    "${local.lz_environment_hyphen}-bas-tf-reader-conndevsub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-bas-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}"
    }
    "${local.lz_environment_hyphen}-afwp-tf-contributor-conndevafwp" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afwp-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-afwp-weu1-001"
    }
    "${local.lz_environment_hyphen}-afwp-tf-blobcontributor-conndevcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afwp-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconndevtfweu1001/blobServices/default/containers/conn-dev"
    }
    "${local.lz_environment_hyphen}-afwp-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afwp-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_dev_subscription_id}/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-afw-tf-blobcontributor-conndevcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afw-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconndevtfweu1001/blobServices/default/containers/conn-dev"
    }
    "${local.lz_environment_hyphen}-afw-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afw-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_dev_subscription_id}/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-afw-tf-reader-conndevhub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afw-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-hub-weu1-001"
    }
    "${local.lz_environment_hyphen}-afw-tf-reader-conndevafwp" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afw-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-afwp-weu1-001"
    }
    "${local.lz_environment_hyphen}-fdfp-tf-blobcontributor-conndevcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-fdfp-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconndevtfweu1001/blobServices/default/containers/conn-dev"
    }
    "${local.lz_environment_hyphen}-fdfp-tf-contributor-conndevafwp" = {
      service_principal_reference = "${local.lz_environment_hyphen}-fdfp-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-fdfp-weu1-001"
    }
    "${local.lz_environment_hyphen}-afd-tf-blobcontributor-conndevcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afd-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconndevtfweu1001/blobServices/default/containers/conn-dev"
    }
    "${local.lz_environment_hyphen}-afd-tf-contributor-conndevafd" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afd-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-afd-weu1-001"
    }
    "${local.lz_environment_hyphen}-afd-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afd-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_dev_subscription_id}/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-afd-tf-reader-conndevfdfp" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afd-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-fdfp-weu1-001"
    }
    "${local.lz_environment_hyphen}-vwan-tf-blobcontributor-conndevcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-vwan-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconndevtfweu1001/blobServices/default/containers/conn-dev"
    }
    "${local.lz_environment_hyphen}-vwan-tf-contributor-conndevvwan" = {
      service_principal_reference = "${local.lz_environment_hyphen}-vwan-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-vwan-weu1-001"
    }
    "${local.lz_environment_hyphen}-vhub-tf-blobcontributor-conndevcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-vhub-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconndevtfweu1001/blobServices/default/containers/conn-dev"
    }
    "${local.lz_environment_hyphen}-vhub-tf-contributor-vhubrg" = {
      service_principal_reference = "${local.lz_environment_hyphen}-vhub-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-vhub-weu1-001"
    }
    "${local.lz_environment_hyphen}-vhub-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-vhub-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_dev_subscription_id}/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-vhub-tf-reader-vwanrg" = {
      service_principal_reference = "${local.lz_environment_hyphen}-vhub-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-vwan-weu1-001"
    }
    "${local.lz_environment_hyphen}-vhub-tf-reader-conndevafwp" = {
      service_principal_reference = "${local.lz_environment_hyphen}-vhub-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-afwp-weu1-001"
    }
    "${local.lz_environment_hyphen}-dnspr-tf-contributor-conndevdnspr" = {
      service_principal_reference = "${local.lz_environment_hyphen}-dnspr-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-dnspr-weu1-001"
    }
    "${local.lz_environment_hyphen}-dnspr-tf-blobcontributor-conndevcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-dnspr-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconndevtfweu1001/blobServices/default/containers/conn-dev"
    }
    "${local.lz_environment_hyphen}-dnspr-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-dnspr-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_dev_subscription_id}/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-dnspr-tf-contributor-mgmtdevlogstorage" = {
      service_principal_reference = "${local.lz_environment_hyphen}-dnspr-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_dev_subscription_id}/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtdevlogweu1001"
    }
    "${local.lz_environment_hyphen}-dnspr-tf-reader-conndevvhub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-dnspr-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-vhub-weu1-001"
    }
    "${local.lz_environment_hyphen}-dnspr-tf-netcontributor-conndevnetwatcher" = {
      service_principal_reference = "${local.lz_environment_hyphen}-dnspr-tf"
      role_definition_name        = "Network Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-netwat-weu1-001/providers/Microsoft.Network/networkWatchers/nw-conn-dev-netwat-weu1-001"
    }
    "${local.lz_environment_hyphen}-dnspr-tf-prvdnscontributor-conndevprvdns" = {
      service_principal_reference = "${local.lz_environment_hyphen}-dnspr-tf"
      role_definition_name        = "Private DNS Zone Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-prvdns-weu1-001"
    }
    "${local.lz_environment_hyphen}-dnspr-tf-reader-conndevsub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-dnspr-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}"
    }
    "${local.lz_environment_hyphen}-pip-tf-blobcontributor-conndevcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-pip-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconndevtfweu1001/blobServices/default/containers/conn-dev"
    }
    "${local.lz_environment_hyphen}-pip-tf-contributor-piprg" = {
      service_principal_reference = "${local.lz_environment_hyphen}-pip-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-pip-weu1-001"
    }
  }
  custom_rbac_role_assignments_service_principals = {
    /*"${local.lz_environment_hyphen}-hub-tf-vnetpeer-appdevnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-hub-tf"
      custom_role_id       = dependency.parent.outputs.rbac_role_definitions["Virtual Network Peerer (Custom)"].id
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-net-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-app-dev-net-weu1-001"
    }*/
    "${local.lz_environment_hyphen}-bas-tf-prefixjoin-conndevhubprefix" = {
      service_principal_reference = "${local.lz_environment_hyphen}-bas-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Public IP Prefix Joiner (Custom)"].id
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-pip-weu1-001/providers/Microsoft.Network/publicIPPrefixes/ippre-conn-dev-pip-weu1-001"
    }
    "${local.lz_environment_hyphen}-bas-tf-vhubjoin-conndevvhub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-bas-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Virtual Hub Joiner (Custom)"].id
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-vhub-weu1-001/providers/Microsoft.Network/virtualHubs/vhub-conn-dev-vhub-weu1-001"
    }
    /*"${local.lz_environment_hyphen}-bas-tf-subnetjoin-conndevhubsubnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-bas-tf"
      custom_role_id       = dependency.parent.outputs.rbac_role_definitions["Subnet Joiner (Custom)"].id
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-hub-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-conn-dev-hub-weu1-001/subnets/AzureBastionSubnet"
    }
    "${local.lz_environment_hyphen}-afw-tf-prefixjoin-conndevhubprefix" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afw-tf"
      custom_role_id       = dependency.parent.outputs.rbac_role_definitions["Public IP Prefix Joiner (Custom)"].id
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-hub-weu1-001/providers/Microsoft.Network/publicIPPrefixes/ippre-conn-dev-hub-weu1-001"
    }
    "${local.lz_environment_hyphen}-afw-tf-subnetjoin-conndevhubsubnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afw-tf"
      custom_role_id       = dependency.parent.outputs.rbac_role_definitions["Subnet Joiner (Custom)"].id
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-hub-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-conn-dev-hub-weu1-001/subnets/AzureFirewallSubnet"
    }
    "${local.lz_environment_hyphen}-afw-tf-fwpoljoin-conndevfwpol" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afw-tf"
      custom_role_id       = dependency.parent.outputs.rbac_role_definitions["Firewall Policy Joiner (Custom)"].id
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-afwp-weu1-001/providers/Microsoft.Network/firewallPolicies/afwp-conn-dev-afwp-weu1-001"
    }
    "${local.lz_environment_hyphen}-afw-tf-fwcont-conndevhub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afw-tf"
      custom_role_id       = dependency.parent.outputs.rbac_role_definitions["Firewall Contributor (Custom)"].id
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-hub-weu1-001"
    }
    "${local.lz_environment_hyphen}-afd-tf-fwcont-conndevhub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afd-tf"
      custom_role_id       = dependency.parent.outputs.rbac_role_definitions["Private Link Joiner (Custom)"].id
      scope                       = "/subscriptions/${include.azure.locals.app_dev_subscription_id}/resourceGroups/rg-app-dev-lb-weu1-001/providers/Microsoft.Network/privateLinkServices/web"
    }*/
    "${local.lz_environment_hyphen}-vhub-tf-fwpoljoin-conndevfwpol" = {
      service_principal_reference = "${local.lz_environment_hyphen}-vhub-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Firewall Policy Joiner (Custom)"].id
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-afwp-weu1-001"
    }
    "${local.lz_environment_hyphen}-vhub-tf-vwanjoin-conndevvwan" = {
      service_principal_reference = "${local.lz_environment_hyphen}-vhub-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Virtual WAN Joiner (Custom)"].id
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-vwan-weu1-001/providers/Microsoft.Network/virtualWans/vwan-conn-dev-vwan-weu1-001"
    }
    "${local.lz_environment_hyphen}-dnspr-tf-vhubjoin-conndevvhub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-dnspr-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Virtual Hub Joiner (Custom)"].id
      scope                       = "/subscriptions/${include.azure.locals.conn_dev_subscription_id}/resourceGroups/rg-conn-dev-vhub-weu1-001/providers/Microsoft.Network/virtualHubs/vhub-conn-dev-vhub-weu1-001"
    }
  }
}
