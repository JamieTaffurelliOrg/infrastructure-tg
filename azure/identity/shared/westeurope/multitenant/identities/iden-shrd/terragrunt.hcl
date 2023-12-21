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
  lz_environment_hyphen = "iden-shrd"
}

inputs = {
  applications = {
    "${local.lz_environment_hyphen}-tf" = {
      display_name = "${local.lz_environment_hyphen}-tf"
      required_resource_accesses = [
        {
          resource_app_id = "00000003-0000-0000-c000-000000000000"
          resource_accesses = [
            {
              id   = "19dbc75e-c2e2-444c-a770-ec69d8559fc7"
              type = "Role"
            },
            {
              id   = "01c0a623-fc9b-48e9-b794-0756f8e8f067"
              type = "Role"
            },
            {
              id   = "246dd0d5-5bd0-4def-940b-0421030a5b68"
              type = "Role"
            }
          ]
        }
      ]
      tags = ["${local.lz_environment_hyphen}-tf"]
    }
  }
  application_federated_identity_credentials = {
    "${local.lz_environment_hyphen}-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:identity.shared.identities.deploy"
    }
  }
  service_principals = {
    "${local.lz_environment_hyphen}-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-tf"
      description              = "Management of Azure AD identities via Terraform"
      admin_consents = [
        {
          app_role_id            = "01c0a623-fc9b-48e9-b794-0756f8e8f067"
          resource_object_id     = "38f372fd-2dbe-465e-9bba-1bcf1039b50d"
          service_principal_name = "${local.lz_environment_hyphen}-tf"
        }
      ]
      tags = ["${local.lz_environment_hyphen}-tf"]
    }
  }
  role_assignments_service_principals = {
    "${local.lz_environment_hyphen}-tf-usradmin" = {
      service_principal_reference = "${local.lz_environment_hyphen}-tf"
      template_id                 = "fe930be7-5e62-47db-91af-98c3a49a38b1"
    }
    "${local.lz_environment_hyphen}-tf-appadmin" = {
      service_principal_reference = "${local.lz_environment_hyphen}-tf"
      template_id                 = "9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3"
    }
    "${local.lz_environment_hyphen}-tf-groupadmin" = {
      service_principal_reference = "${local.lz_environment_hyphen}-tf"
      template_id                 = "fdd7a751-b60b-444a-984c-02652fe8fa1c"
    }
    "${local.lz_environment_hyphen}-tf-globaladmin" = {
      service_principal_reference = "${local.lz_environment_hyphen}-tf"
      template_id                 = "62e90394-69f5-4237-9190-012177145e10"
    }
  }
  rbac_role_assignments_service_principals = {
    "${local.lz_environment_hyphen}-tf-uaa-org" = {
      service_principal_reference = "${local.lz_environment_hyphen}-tf"
      role_definition_name        = "User Access Administrator"
      scope                       = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
    }
    "${local.lz_environment_hyphen}-tf-uaa-sub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-tf"
      role_definition_name        = "User Access Administrator"
      scope                       = "/providers/Microsoft.Subscription"
    }
    "${local.lz_environment_hyphen}-tf-blobcontributor-idenshrdcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.iden_shrd_subscription_id}/resourceGroups/rg-iden-shrd-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtidenshrdtfweu1001/blobServices/default/containers/iden-shrd"
    }
    "${local.lz_environment_hyphen}-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_prod_subscription_id}/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-tf-contributor-arm" = {
      service_principal_reference = "${local.lz_environment_hyphen}-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.iden_shrd_subscription_id}/resourceGroups/rg-iden-shrd-arm-weu1-001"
    }
    "${local.lz_environment_hyphen}-tf-tagcontributor-jtmg" = {
      service_principal_reference = "${local.lz_environment_hyphen}-tf"
      role_definition_name        = "Tag Contributor"
      scope                       = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
    }
  }
}
