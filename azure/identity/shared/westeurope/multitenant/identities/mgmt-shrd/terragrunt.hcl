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
  lz_environment_hyphen = "mgmt-shrd"
}

inputs = {
  applications = {
    "${local.lz_environment_hyphen}-vmimg-tf" = {
      display_name = "${local.lz_environment_hyphen}-vmimg-tf"
      tags         = ["${local.lz_environment_hyphen}-vmimg-tf"]
    }
    "${local.lz_environment_hyphen}-acr-tf" = {
      display_name = "${local.lz_environment_hyphen}-acr-tf"
      tags         = ["${local.lz_environment_hyphen}-acr-tf"]
    }
    "vm-scripts" = {
      display_name = "vm-scripts"
      tags         = ["vm-scripts"]
    }
  }
  application_federated_identity_credentials = {
    "${local.lz_environment_hyphen}-vmimg-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-vmimg-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:management.shared.vm-images.deploy"
    }
    "${local.lz_environment_hyphen}-acr-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "${local.lz_environment_hyphen}-acr-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:management.shared.acr.deploy"
    }
    "vm-scripts" = {
      display_name             = "deploy"
      application_id_reference = "vm-scripts"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/vm-config:environment:deploy"
    }
  }
  service_principals = {
    "${local.lz_environment_hyphen}-vmimg-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-vmimg-tf"
      description              = "Management of shared image gallery infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-vmimg-tf"]
    }
    "${local.lz_environment_hyphen}-acr-tf" = {
      application_id_reference = "${local.lz_environment_hyphen}-acr-tf"
      description              = "Management of container registry infrastructure via Terraform"
      tags                     = ["${local.lz_environment_hyphen}-acr-tf"]
    }
    "vm-scripts" = {
      application_id_reference = "vm-scripts"
      description              = "Deployment of scripts used for VM configuration to storage account"
      tags                     = ["vm-scripts"]
    }
  }
  objects = {
    "galmgmtshrdvmimgweu1001" = {
      object_id = "150a426e-0f57-46d9-8376-b4cb7f33a70c"
    }
  }
  rbac_role_assignments_service_principals = {
    "${local.lz_environment_hyphen}-vmimg-tf-contributor-mgmtshrdvmimg" = {
      service_principal_reference = "${local.lz_environment_hyphen}-vmimg-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_shrd_subscription_id}/resourceGroups/rg-mgmt-shrd-vmimg-weu1-001"
    }
    "${local.lz_environment_hyphen}-vmimg-tf-blobcontributor-mgmtshrdcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-vmimg-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_shrd_subscription_id}/resourceGroups/rg-mgmt-shrd-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtshrdtfweu1001/blobServices/default/containers/mgmt-shrd"
    }
    "${local.lz_environment_hyphen}-vmimg-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-vmimg-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_prod_subscription_id}/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "${local.lz_environment_hyphen}-acr-tf-contributor-mgmtshrdacr" = {
      service_principal_reference = "${local.lz_environment_hyphen}-acr-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_shrd_subscription_id}/resourceGroups/rg-mgmt-shrd-acr-weu1-001"
    }
    "${local.lz_environment_hyphen}-acr-tf-blobcontributor-mgmtshrdcontainer" = {
      service_principal_reference = "${local.lz_environment_hyphen}-acr-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_shrd_subscription_id}/resourceGroups/rg-mgmt-shrd-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtshrdtfweu1001/blobServices/default/containers/mgmt-shrd"
    }
    "${local.lz_environment_hyphen}-acr-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "${local.lz_environment_hyphen}-acr-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/${include.azure.locals.mgmt_prod_subscription_id}/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
  }
  rbac_role_assignments_objects = {
    /*"galmgmtshrdvmimgweu1001-blobreader-mgmtshrdscriptscontainer" = {
      object_reference     = "galmgmtshrdvmimgweu1001"
      role_definition_name = "Storage Blob Data Reader"
      scope                = "/subscriptions/${include.azure.locals.mgmt_shrd_subscription_id}/resourceGroups/rg-mgmt-shrd-vmimg-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtshrdvmimgweu1001/blobServices/default/containers/scripts"
    }*/
  }
  custom_rbac_role_assignments_objects = {
    "galmgmtshrdvmimgweu1001-imgbuilder" = {
      object_reference = "galmgmtshrdvmimgweu1001"
      custom_role_id   = dependency.parent.outputs.rbac_role_definitions["Image Creator (Custom)"].role_definition_resource_id
      scope            = "/subscriptions/${include.azure.locals.mgmt_shrd_subscription_id}/resourceGroups/rg-mgmt-shrd-vmimg-weu1-001/providers/Microsoft.Compute/galleries/galmgmtshrdvmimgweu1001"
    }
  }
  custom_rbac_role_service_principals = {
    "${local.lz_environment_hyphen}-vmimg-tf-svcfabmshreg-mgmtshrdsub" = {
      service_principal_reference = "${local.lz_environment_hyphen}-vmimg-tf"
      custom_role_id              = dependency.parent.outputs.rbac_role_definitions["Service Fabric Mesh Register (Custom)"].role_definition_resource_id
      scope                       = "/subscriptions/${include.azure.locals.mgmt_shrd_subscription_id}"
    }
  }
}
