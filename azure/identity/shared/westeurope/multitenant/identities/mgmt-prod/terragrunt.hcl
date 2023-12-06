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
  lz_environment_hyphen = "mgmt-prod"
}

inputs = {
  applications = {
    "${local.lz_environment_hyphen}-logging-tf" = {
      display_name = "${local.lz_environment_hyphen}-logging-tf"
      tags         = ["${local.lz_environment_hyphen}-logging-tf"]
    }
  }
  application_federated_identity_credentials = {
    "${local.lz_environment_hyphen}-logging-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-logging-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:management.prod.logging.deploy"
    }
  }
  service_principals = {
    "${local.lz_environment_hyphen}-logging-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-logging-tf"
      description              = "Management of prod logging infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-logging-tf"]
    }
  }
  rbac_role_assignments_service_principals = {
    "${local.lz_environment_hyphen}-logging-tf-blobcontributor-mgmtprodcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-logging-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_prod_subscription_id}/resourceGroups/rg-mgmt-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtprodtfweu1001/blobServices/default/containers/mgmt-prod"
    }
    "${local.lz_environment_hyphen}-logging-tf-contributor-loggingrg" = {
      service_principal_reference = "${local.lz_environment_hyphen}-logging-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_prod_subscription_id}/resourceGroups/rg-mgmt-prod-log-weu1-001"
    }
  }
}
