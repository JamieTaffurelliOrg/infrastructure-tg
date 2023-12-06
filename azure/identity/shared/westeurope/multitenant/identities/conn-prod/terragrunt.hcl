terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-identity-tf///?ref=0.1.31"
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
  lz_environment_hyphen = "conn-prod"
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
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.prod.hub-vnet.deploy"
    }
    "${local.lz_environment_hyphen}-prvdns-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-prvdns-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.prod.private-dns.deploy"
    }
    "${local.lz_environment_hyphen}-bas-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-bas-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.prod.bastion.deploy"
    }
    "${local.lz_environment_hyphen}-pip-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-pip-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.prod.public-ip.deploy"
    }
    "${local.lz_environment_hyphen}-afwp-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-afwp-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.prod.firewall-policy.deploy"
    }
    "${local.lz_environment_hyphen}-afw-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-afw-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.prod.firewall.deploy"
    }
    "${local.lz_environment_hyphen}-fdfp-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-fdfp-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.prod.front-door-waf-policy.deploy"
    }
    "${local.lz_environment_hyphen}-afd-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-afd-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.prod.front-door.deploy"
    }
    "${local.lz_environment_hyphen}-vwan-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-vwan-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.prod.virtual-wan.deploy"
    }
    "${local.lz_environment_hyphen}-vhub-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-vhub-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.prod.virtual-hub.deploy"
    }
    "${local.lz_environment_hyphen}-dnspr-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-dnspr-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.prod.dns-resolver.deploy"
    }
  }
  service_principals = {
    "${local.lz_environment_hyphen}-hub-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-hub-tf"
      description              = "Management of prod hub network infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-hub-tf"]
    }
    "${local.lz_environment_hyphen}-prvdns-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-prvdns-tf"
      description              = "Management of prod private DNS infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-prvdns-tf"]
    }
    "${local.lz_environment_hyphen}-bas-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-bas-tf"
      description              = "Management of prod Bastion infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-bas-tf"]
    }
    "${local.lz_environment_hyphen}-afwp-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-afwp-tf"
      description              = "Management of prod firewall policy infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-afwp-tf"]
    }
    "${local.lz_environment_hyphen}-afw-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-afw-tf"
      description              = "Management of prod firewall policy infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-afw-tf"]
    }
    "${local.lz_environment_hyphen}-fdfp-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-fdfp-tf"
      description              = "Management of prod front door waf policy infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-fdfp-tf"]
    }
    "${local.lz_environment_hyphen}-afd-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-afd-tf"
      description              = "Management of prod front door infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-afd-tf"]
    }
    "${local.lz_environment_hyphen}-vwan-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-vwan-tf"
      description              = "Management of prod virtual wan infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-vwan-tf"]
    }
    "${local.lz_environment_hyphen}-vhub-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-vhub-tf"
      description              = "Management of prod virtual hub infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-vhub-tf"]
    }
    "${local.lz_environment_hyphen}-dnspr-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-dnspr-tf"
      description              = "Management of prod dns resolver infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-dnspr-tf"]
    }
    "${local.lz_environment_hyphen}-pip-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-pip-tf"
      description              = "Management of prod public ip infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-pip-tf"]
    }
  }
  rbac_role_assignments_service_principals = {
    "${local.lz_environment_hyphen}-hub-tf-blobcontributor-connprodcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-hub-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconnprodtfweu1001/blobServices/default/containers/conn-prod"
    }
    "${local.lz_environment_hyphen}-hub-tf-contributor-hubrg" = {
      service_principal_reference = "${local.lz_environment_hyphen}-hub-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-hub-weu1-001"
    }
    "${local.lz_environment_hyphen}-hub-tf-reader-sub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-hub-tf"
      role_definition_name        = "Reader"
      scope                       = "/providers/Microsoft.Subscription"
    }
    "${local.lz_environment_hyphen}-hub-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-hub-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_prod_subscription_id}/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-hub-tf-contributor-mgmtprodlogstorage" = {
      service_principal_reference = "${local.lz_environment_hyphen}-hub-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_prod_subscription_id}/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtprodlogweu1002"
    }
    "${local.lz_environment_hyphen}-hub-tf-netcontributor-connprodnetwatcher" = {
      service_principal_reference = "${local.lz_environment_hyphen}-hub-tf"
      role_definition_name        = "Network Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-netwat-weu1-001/providers/Microsoft.Network/networkWatchers/nw-conn-prod-netwat-weu1-001"
    }
    "${local.lz_environment_hyphen}-hub-tf-reader-connprodsub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-hub-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}cription_id}"
    }
    "${local.lz_environment_hyphen}-hub-tf-reader-${local.lz_environment_concat}sub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-hub-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}"
    }
    "${local.lz_environment_hyphen}-hub-tf-prvdnscontributor-connprodprvdns" = {
      service_principal_reference = "${local.lz_environment_hyphen}-hub-tf"
      role_definition_name        = "Private DNS Zone Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-prvdns-weu1-001"
    }
    "${local.lz_environment_hyphen}-prvdns-tf-contributor-connprodprvdns" = {
      service_principal_reference = "${local.lz_environment_hyphen}-prvdns-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-prvdns-weu1-001"
    }
    "${local.lz_environment_hyphen}-prvdns-tf-blobcontributor-connprodcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-prvdns-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconnprodtfweu1001/blobServices/default/containers/conn-prod"
    }
    "${local.lz_environment_hyphen}-bas-tf-contributor-connprodbas" = {
      service_principal_reference = "${local.lz_environment_hyphen}-bas-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-bas-weu1-001"
    }
    "${local.lz_environment_hyphen}-bas-tf-blobcontributor-connprodcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-bas-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconnprodtfweu1001/blobServices/default/containers/conn-prod"
    }
    "${local.lz_environment_hyphen}-bas-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-bas-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_prod_subscription_id}/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-bas-tf-reader-connprodvhub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-bas-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-vhub-weu1-001"
    }
    "${local.lz_environment_hyphen}-bas-tf-reader-connprodpip" = {
      service_principal_reference = "${local.lz_environment_hyphen}-bas-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-pip-weu1-001"
    }
    "${local.lz_environment_hyphen}-bas-tf-contributor-mgmtprodlogstorage" = {
      service_principal_reference = "${local.lz_environment_hyphen}-bas-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_prod_subscription_id}/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtprodlogweu1002"
    }
    "${local.lz_environment_hyphen}-bas-tf-netcontributor-connprodnetwatcher" = {
      service_principal_reference = "${local.lz_environment_hyphen}-bas-tf"
      role_definition_name        = "Network Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-netwat-weu1-001/providers/Microsoft.Network/networkWatchers/nw-conn-prod-netwat-weu1-001"
    }
    "${local.lz_environment_hyphen}-bas-tf-reader-connprodsub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-bas-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}"
    }
    "${local.lz_environment_hyphen}-afwp-tf-contributor-connprodafwp" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afwp-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-afwp-weu1-001"
    }
    "${local.lz_environment_hyphen}-afwp-tf-blobcontributor-connprodcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afwp-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconnprodtfweu1001/blobServices/default/containers/conn-prod"
    }
    "${local.lz_environment_hyphen}-afwp-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afwp-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_prod_subscription_id}/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-afw-tf-blobcontributor-connprodcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afw-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}cription_id}/resourceGroups/rg-conn-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconnprodtfweu1001/blobServices/default/containers/conn-prod"
    }
    "${local.lz_environment_hyphen}-afw-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afw-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_prod_subscription_id}/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-afw-tf-reader-connprodhub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afw-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-hub-weu1-001"
    }
    "${local.lz_environment_hyphen}-afw-tf-reader-connprodafwp" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afw-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-afwp-weu1-001"
    }
    "${local.lz_environment_hyphen}-fdfp-tf-blobcontributor-connprodcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-fdfp-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconnprodtfweu1001/blobServices/default/containers/conn-prod"
    }
    "${local.lz_environment_hyphen}-fdfp-tf-contributor-connprodafwp" = {
      service_principal_reference = "${local.lz_environment_hyphen}-fdfp-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-fdfp-weu1-001"
    }
    "${local.lz_environment_hyphen}-afd-tf-blobcontributor-connprodcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afd-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconnprodtfweu1001/blobServices/default/containers/conn-prod"
    }
    "${local.lz_environment_hyphen}-afd-tf-contributor-connprodafd" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afd-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-afd-weu1-001"
    }
    "${local.lz_environment_hyphen}-afd-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afd-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_prod_subscription_id}/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-afd-tf-reader-connprodfdfp" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afd-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-fdfp-weu1-001"
    }
    "${local.lz_environment_hyphen}-vwan-tf-blobcontributor-connprodcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-vwan-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconnprodtfweu1001/blobServices/default/containers/conn-prod"
    }
    "${local.lz_environment_hyphen}-vwan-tf-contributor-connprodvwan" = {
      service_principal_reference = "${local.lz_environment_hyphen}-vwan-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-vwan-weu1-001"
    }
    "${local.lz_environment_hyphen}-vhub-tf-blobcontributor-connprodcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-vhub-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconnprodtfweu1001/blobServices/default/containers/conn-prod"
    }
    "${local.lz_environment_hyphen}-vhub-tf-contributor-vhubrg" = {
      service_principal_reference = "${local.lz_environment_hyphen}-vhub-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}cription_id}/resourceGroups/rg-conn-prod-vhub-weu1-001"
    }
    "${local.lz_environment_hyphen}-vhub-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-vhub-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_prod_subscription_id}/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-vhub-tf-reader-vwanrg" = {
      service_principal_reference = "${local.lz_environment_hyphen}-vhub-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-vwan-weu1-001"
    }
    "${local.lz_environment_hyphen}-vhub-tf-reader-connprodafwp" = {
      service_principal_reference = "${local.lz_environment_hyphen}-vhub-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-afwp-weu1-001"
    }
    "${local.lz_environment_hyphen}-dnspr-tf-contributor-connproddnspr" = {
      service_principal_reference = "${local.lz_environment_hyphen}-dnspr-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-dnspr-weu1-001"
    }
    "${local.lz_environment_hyphen}-dnspr-tf-blobcontributor-connprodcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-dnspr-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconnprodtfweu1001/blobServices/default/containers/conn-prod"
    }
    "${local.lz_environment_hyphen}-dnspr-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-dnspr-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_prod_subscription_id}/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-dnspr-tf-contributor-mgmtprodlogstorage" = {
      service_principal_reference = "${local.lz_environment_hyphen}-dnspr-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_prod_subscription_id}/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtprodlogweu1002"
    }
    "${local.lz_environment_hyphen}-dnspr-tf-reader-connprodvhub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-dnspr-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-vhub-weu1-001"
    }
    "${local.lz_environment_hyphen}-dnspr-tf-netcontributor-connprodnetwatcher" = {
      service_principal_reference = "${local.lz_environment_hyphen}-dnspr-tf"
      role_definition_name        = "Network Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-netwat-weu1-001/providers/Microsoft.Network/networkWatchers/nw-conn-prod-netwat-weu1-001"
    }
    "${local.lz_environment_hyphen}-dnspr-tf-prvdnscontributor-connprodprvdns" = {
      service_principal_reference = "${local.lz_environment_hyphen}-dnspr-tf"
      role_definition_name        = "Private DNS Zone Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-prvdns-weu1-001"
    }
    "${local.lz_environment_hyphen}-dnspr-tf-reader-connprodsub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-dnspr-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}"
    }
    "${local.lz_environment_hyphen}-pip-tf-blobcontributor-connprodcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-pip-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconnprodtfweu1001/blobServices/default/containers/conn-prod"
    }
    "${local.lz_environment_hyphen}-pip-tf-contributor-piprg" = {
      service_principal_reference = "${local.lz_environment_hyphen}-pip-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-pip-weu1-001"
    }
  }
  custom_rbac_role_assignments_service_principals = {
    /*"${local.lz_environment_hyphen}-hub-tf-vnetpeer-appprodnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-hub-tf"
      custom_role_reference       = "Virtual Network Peerer (Custom)"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-net-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-app-prod-net-weu1-001"
    }*/
    "${local.lz_environment_hyphen}-bas-tf-prefixjoin-connprodhubprefix" = {
      service_principal_reference = "${local.lz_environment_hyphen}-bas-tf"
      custom_role_reference       = "Public IP Prefix Joiner (Custom)"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-pip-weu1-001/providers/Microsoft.Network/publicIPPrefixes/ippre-conn-prod-pip-weu1-001"
    }
    "${local.lz_environment_hyphen}-bas-tf-vhubjoin-connprodvhub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-bas-tf"
      custom_role_reference       = "Virtual Hub Joiner (Custom)"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-vhub-weu1-001/providers/Microsoft.Network/virtualHubs/vhub-conn-prod-vhub-weu1-001"
    }
    /*"${local.lz_environment_hyphen}-bas-tf-subnetjoin-connprodhubsubnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-bas-tf"
      custom_role_reference       = "Subnet Joiner (Custom)"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-hub-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-conn-prod-hub-weu1-001/subnets/AzureBastionSubnet"
    }
    "${local.lz_environment_hyphen}-afw-tf-prefixjoin-connprodhubprefix" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afw-tf"
      custom_role_reference       = "Public IP Prefix Joiner (Custom)"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-hub-weu1-001/providers/Microsoft.Network/publicIPPrefixes/ippre-conn-prod-hub-weu1-001"
    }
    "${local.lz_environment_hyphen}-afw-tf-subnetjoin-connprodhubsubnet" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afw-tf"
      custom_role_reference       = "Subnet Joiner (Custom)"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-hub-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-conn-prod-hub-weu1-001/subnets/AzureFirewallSubnet"
    }
    "${local.lz_environment_hyphen}-afw-tf-fwpoljoin-connprodfwpol" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afw-tf"
      custom_role_reference       = "Firewall Policy Joiner (Custom)"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-afwp-weu1-001/providers/Microsoft.Network/firewallPolicies/afwp-conn-prod-afwp-weu1-001"
    }
    "${local.lz_environment_hyphen}-afw-tf-fwcont-connprodhub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afw-tf"
      custom_role_reference       = "Firewall Contributor (Custom)"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-hub-weu1-001"
    }
    "${local.lz_environment_hyphen}-afd-tf-fwcont-connprodhub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-afd-tf"
      custom_role_reference       = "Private Link Joiner (Custom)"
      scope                       = "/subscriptions/${include.azure.locals.app_prod_subscription_id}/resourceGroups/rg-app-prod-lb-weu1-001/providers/Microsoft.Network/privateLinkServices/web"
    }*/
    "${local.lz_environment_hyphen}-vhub-tf-fwpoljoin-connprodfwpol" = {
      service_principal_reference = "${local.lz_environment_hyphen}-vhub-tf"
      custom_role_reference       = "Firewall Policy Joiner (Custom)"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-afwp-weu1-001"
    }
    "${local.lz_environment_hyphen}-vhub-tf-vwanjoin-connprodvwan" = {
      service_principal_reference = "${local.lz_environment_hyphen}-vhub-tf"
      custom_role_reference       = "Virtual WAN Joiner (Custom)"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-vwan-weu1-001/providers/Microsoft.Network/virtualWans/vwan-conn-prod-vwan-weu1-001"
    }
    "${local.lz_environment_hyphen}-dnspr-tf-vhubjoin-connprodvhub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-dnspr-tf"
      custom_role_reference       = "Virtual Hub Joiner (Custom)"
      scope                       = "/subscriptions/${include.azure.locals.conn_prod_subscription_id}/resourceGroups/rg-conn-prod-vhub-weu1-001/providers/Microsoft.Network/virtualHubs/vhub-conn-prod-vhub-weu1-001"
    }
  }
}
