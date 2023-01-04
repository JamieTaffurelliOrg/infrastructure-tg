terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-identity-tf///?ref=0.1.6"
}

include {
  path = find_in_parent_folders()
}

locals {

}

inputs = {

  applications = {
    "setup-landing-zones-tf" = {
      display_name = "setup-landing-zones-tf"
      tags         = ["landing-zone-setup"]
    }
    "github-tf" = {
      display_name = "github-tf"
      tags         = ["github-tf"]
    }
    "identity-tf" = {
      display_name = "identity-tf"
      tags         = ["identity-tf"]
    }
    "mgmt-dev-logging-tf" = {
      display_name = "mgmt-dev-logging-tf"
      tags         = ["mgmt-dev-logging-tf"]
    }
    "mgmt-prod-logging-tf" = {
      display_name = "mgmt-prod-logging-tf"
      tags         = ["mgmt-prod-logging-tf"]
    }
    "conn-dev-hub-tf" = {
      display_name = "conn-dev-hub-tf"
      tags         = ["conn-dev-hub-tf"]
    }
    "conn-prod-hub-tf" = {
      display_name = "conn-prod-hub-tf"
      tags         = ["conn-prod-hub-tf"]
    }
    "conn-dev-prvdns-tf" = {
      display_name = "conn-dev-prvdns-tf"
      tags         = ["conn-dev-prvdns-tf"]
    }
    "conn-prod-prvdns-tf" = {
      display_name = "conn-prod-prvdns-tf"
      tags         = ["conn-prod-prvdns-tf"]
    }
    "conn-dev-bas-tf" = {
      display_name = "conn-dev-bas-tf"
      tags         = ["conn-dev-bas-tf"]
    }
    "conn-prod-bas-tf" = {
      display_name = "conn-prod-bas-tf"
      tags         = ["conn-prod-bas-tf"]
    }
  }
  application_federated_identity_credentials = {
    "setup-landing-zones-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "setup-landing-zones-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:azure.setup.prod.landing-zones.deploy"
    }
    "github-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "github-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:github.jamietaffurelliorg.deploy"
    }
    "identity-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "identity-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:identity.shared.identities.deploy"
    }
    "mgmt-dev-logging-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "mgmt-dev-logging-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:management.dev.logging.deploy"
    }
    "mgmt-prod-logging-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "mgmt-prod-logging-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:management.prod.logging.deploy"
    }
    "conn-dev-hub-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "conn-dev-hub-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.dev.hub-vnet.deploy"
    }
    "conn-prod-hub-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "conn-prod-hub-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.prod.hub-vnet.deploy"
    }
    "conn-dev-prvdns-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "conn-dev-prvdns-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.dev.private-dns.deploy"
    }
    "conn-prod-prvdns-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "conn-prod-prvdns-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.prod.private-dns.deploy"
    }
    "conn-dev-bas-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "conn-dev-bas-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.dev.bastion.deploy"
    }
    "conn-prod-bas-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "conn-prod-bas-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.prod.bastion.deploy"
    }
  }
  service_principals = {
    "setup-landing-zones-tf" = {
      application_id_reference = "setup-landing-zones-tf"
      description              = "landing zone setup with Terraform"
      tags                     = ["landing-zone-setup"]
    }
    "github-tf" = {
      application_id_reference = "github-tf"
      description              = "Management of GitHub via Terraform"
      tags                     = ["github-tf"]
    }
    "identity-tf" = {
      application_id_reference = "identity-tf"
      description              = "Management of Azure AD identities via Terraform"
      tags                     = ["identity-tf"]
    }
    "mgmt-dev-logging-tf" = {
      application_id_reference = "mgmt-dev-logging-tf"
      description              = "Management of dev logging infrastructure via Terraform"
      tags                     = ["mgmt-dev-logging-tf"]
    }
    "mgmt-prod-logging-tf" = {
      application_id_reference = "mgmt-prod-logging-tf"
      description              = "Management of prod logging infrastructure via Terraform"
      tags                     = ["mgmt-prod-logging-tf"]
    }
    "conn-dev-hub-tf" = {
      application_id_reference = "conn-dev-hub-tf"
      description              = "Management of dev hub network infrastructure via Terraform"
      tags                     = ["conn-dev-hub-tf"]
    }
    "conn-prod-hub-tf" = {
      application_id_reference = "conn-prod-hub-tf"
      description              = "Management of prod hub network infrastructure via Terraform"
      tags                     = ["conn-prod-hub-tf"]
    }
    "conn-dev-prvdns-tf" = {
      application_id_reference = "conn-dev-prvdns-tf"
      description              = "Management of dev private DNS infrastructure via Terraform"
      tags                     = ["conn-dev-prvdns-tf"]
    }
    "conn-prod-prvdns-tf" = {
      application_id_reference = "conn-prod-prvdns-tf"
      description              = "Management of prod private DNS infrastructure via Terraform"
      tags                     = ["conn-prod-prvdns-tf"]
    }
    "conn-dev-bas-tf" = {
      application_id_reference = "conn-dev-bas-tf"
      description              = "Management of dev Bastion infrastructure via Terraform"
      tags                     = ["conn-dev-bas-tf"]
    }
    "conn-prod-prvdns-tf" = {
      application_id_reference = "conn-prod-bas-tf"
      description              = "Management of prod Bastion infrastructure via Terraform"
      tags                     = ["conn-prod-bas-tf"]
    }
  }
  role_assignments_service_principals = {
    "identity-tf-usradmin" = {
      service_principal_reference = "identity-tf"
      template_id                 = "fe930be7-5e62-47db-91af-98c3a49a38b1"
    }
    "identity-tf-appadmin" = {
      service_principal_reference = "identity-tf"
      template_id                 = "9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3"
    }
  }
  rbac_role_assignments_service_principals = {
    "setup-landing-zones-tf-owner-org" = {
      service_principal_reference = "setup-landing-zones-tf"
      role_definition_name        = "Owner"
      scope                       = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
    }
    "setup-landing-zones-tf-reader-sub" = {
      service_principal_reference = "setup-landing-zones-tf"
      role_definition_name        = "Reader"
      scope                       = "/providers/Microsoft.Subscription"
    }
    "setup-landing-zones-tf-blobcontributor-setupprod" = {
      service_principal_reference = "setup-landing-zones-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/105036b2-81a9-4d2d-955b-74e9aead3b29/resourceGroups/rg-stp-prod-tf-frc1-001/providers/Microsoft.Storage/storageAccounts/stjtstpprodtffrc1001/blobServices/default/containers/setup-prod"
    }
    "github-tf-blobcontributor-githubcontainer" = {
      service_principal_reference = "github-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/09c57f23-65cf-4594-8285-dc99ec8a627e/resourceGroups/rg-tfext-prod-tf-frc1-001/providers/Microsoft.Storage/storageAccounts/stjttfextpprodtffrc1001/blobServices/default/containers/github"
    }
    "identity-tf-uaa-org" = {
      service_principal_reference = "identity-tf"
      role_definition_name        = "User Access Administrator"
      scope                       = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
    }
    "identity-tf-uaa-sub" = {
      service_principal_reference = "identity-tf"
      role_definition_name        = "User Access Administrator"
      scope                       = "/providers/Microsoft.Subscription"
    }
    "identity-tf-blobcontributor-idenshrdcontainer" = {
      service_principal_reference = "identity-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/dad37d44-b43c-4baf-8681-77016fb30901/resourceGroups/rg-iden-shrd-tf-frc1-001/providers/Microsoft.Storage/storageAccounts/stjtidenshrdtffrc1001/blobServices/default/containers/iden-shrd"
    }
    "identity-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "identity-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/510b35a4-6985-403e-939b-305da79e99bc/resourceGroups/rg-mgmt-prod-log-wus2-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-wus2-001"
    }
    "mgmt-dev-logging-tf-blobcontributor-mgmtdevcontainer" = {
      service_principal_reference = "mgmt-dev-logging-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/4593b317-03e9-4533-9f41-e0d4b6da338c/resourceGroups/rg-mgmt-dev-tf-frc1-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtdevtffrc1001/blobServices/default/containers/mgmt-dev"
    }
    "mgmt-dev-logging-tf-contributor-loggingrg" = {
      service_principal_reference = "mgmt-dev-logging-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/4593b317-03e9-4533-9f41-e0d4b6da338c/resourceGroups/rg-mgmt-dev-log-wus2-001"
    }
    "mgmt-prod-logging-tf-blobcontributor-mgmtprodcontainer" = {
      service_principal_reference = "mgmt-prod-logging-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/510b35a4-6985-403e-939b-305da79e99bc/resourceGroups/rg-mgmt-prod-tf-frc1-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtprodtffrc1001/blobServices/default/containers/mgmt-prod"
    }
    "mgmt-prod-logging-tf-contributor-loggingrg" = {
      service_principal_reference = "mgmt-prod-logging-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/510b35a4-6985-403e-939b-305da79e99bc/resourceGroups/rg-mgmt-prod-log-wus2-001"
    }
    "conn-dev-hub-tf-blobcontributor-conndevcontainer" = {
      service_principal_reference = "conn-dev-hub-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-tf-frc1-001/providers/Microsoft.Storage/storageAccounts/stjtconndevtffrc1001/blobServices/default/containers/conn-dev"
    }
    "conn-dev-hub-tf-contributor-hubrg" = {
      service_principal_reference = "conn-dev-hub-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-hub-wus2-001"
    }
    "conn-dev-hub-tf-reader-sub" = {
      service_principal_reference = "conn-dev-hub-tf"
      role_definition_name        = "Reader"
      scope                       = "/providers/Microsoft.Subscription"
    }
    "conn-dev-hub-tf-monconributor-mgmtdevlogs" = {
      service_principal_reference = "conn-dev-hub-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/4593b317-03e9-4533-9f41-e0d4b6da338c/resourceGroups/rg-mgmt-dev-log-wus2-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-wus2-001"
    }
    "conn-dev-hub-tf-contributor-mgmtdevlogstorage" = {
      service_principal_reference = "conn-dev-hub-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/4593b317-03e9-4533-9f41-e0d4b6da338c/resourceGroups/rg-mgmt-dev-log-wus2-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtdevlogwus2001"
    }
    "conn-dev-hub-tf-netcontributor-conndevnetwatcher" = {
      service_principal_reference = "conn-dev-hub-tf"
      role_definition_name        = "Network Contributor"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-netwat-frc1-001/providers/Microsoft.Network/networkWatchers/nw-conn-dev-netwat-wus2-001"
    }
    "conn-dev-hub-tf-reader-conndevsub" = {
      service_principal_reference = "conn-dev-hub-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9"
    }
    "conn-dev-hub-tf-prvdnscontributor-conndevprvdns" = {
      service_principal_reference = "conn-dev-hub-tf"
      role_definition_name        = "Private DNS Zone Contributor"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-prvdns-wus2-001"
    }
    "conn-dev-prvdns-tf-contributor-conndevprvdns" = {
      service_principal_reference = "conn-dev-prvdns-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-prvdns-wus2-001"
    }
    "conn-dev-prvdns-tf-blobcontributor-conndevcontainer" = {
      service_principal_reference = "conn-dev-prvdns-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-tf-frc1-001/providers/Microsoft.Storage/storageAccounts/stjtconndevtffrc1001/blobServices/default/containers/conn-dev"
    }
    "conn-dev-bas-tf-contributor-conndevbas" = {
      service_principal_reference = "conn-dev-bas-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-bas-wus2-001"
    }
    "conn-dev-bas-tf-blobcontributor-conndevcontainer" = {
      service_principal_reference = "conn-dev-bas-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-tf-frc1-001/providers/Microsoft.Storage/storageAccounts/stjtconndevtffrc1001/blobServices/default/containers/conn-dev"
    }
    "conn-dev-bas-tf-monconributor-mgmtdevlogs" = {
      service_principal_reference = "conn-dev-bas-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/4593b317-03e9-4533-9f41-e0d4b6da338c/resourceGroups/rg-mgmt-dev-log-wus2-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-wus2-001"
    }
    "conn-prod-hub-tf-blobcontributor-connprodcontainer" = {
      service_principal_reference = "conn-prod-hub-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-tf-frc1-001/providers/Microsoft.Storage/storageAccounts/stjtconnprodtffrc1001/blobServices/default/containers/conn-prod"
    }
    "conn-prod-hub-tf-contributor-hubrg" = {
      service_principal_reference = "conn-prod-hub-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-hub-wus2-001"
    }
    "conn-prod-hub-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "conn-prod-hub-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/510b35a4-6985-403e-939b-305da79e99bc/resourceGroups/rg-mgmt-prod-log-wus2-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-wus2-001"
    }
    "conn-prod-hub-tf-contributor-mgmtprodlogstorage" = {
      service_principal_reference = "conn-prod-hub-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/510b35a4-6985-403e-939b-305da79e99bc/resourceGroups/rg-mgmt-prod-log-wus2-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtprodlogwus2001"
    }
    "conn-prod-hub-tf-netcontributor-connprodnetwatcher" = {
      service_principal_reference = "conn-prod-hub-tf"
      role_definition_name        = "Network Contributor"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-netwat-frc1-001/providers/Microsoft.Network/networkWatchers/nw-conn-prod-netwat-wus2-001"
    }
    "conn-prod-hub-tf-reader-conprodsub" = {
      service_principal_reference = "conn-prod-hub-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4"
    }
    "conn-prod-hub-tf-prvdnscontributor-conndevprvdns" = {
      service_principal_reference = "conn-prod-hub-tf"
      role_definition_name        = "Private DNS Zone Contributor"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-prvdns-wus2-001"
    }
    "conn-prod-prvdns-tf-contributor-connprodprvdns" = {
      service_principal_reference = "conn-prod-prvdns-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-prvdns-wus2-001"
    }
    "conn-prod-prvdns-tf-blobcontributor-connprodcontainer" = {
      service_principal_reference = "conn-prod-prvdns-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-tf-frc1-001/providers/Microsoft.Storage/storageAccounts/stjtconnprodtffrc1001/blobServices/default/containers/conn-prod"
    }
    "conn-prod-bas-tf-contributor-connprodprvdns" = {
      service_principal_reference = "conn-prod-bas-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-bas-wus2-001"
    }
    "conn-prod-bas-tf-blobcontributor-connprodcontainer" = {
      service_principal_reference = "conn-prod-bas-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-tf-frc1-001/providers/Microsoft.Storage/storageAccounts/stjtconnprodtffrc1001/blobServices/default/containers/conn-prod"
    }
    "conn-prod-bas-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "conn-prod-bas-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/510b35a4-6985-403e-939b-305da79e99bc/resourceGroups/rg-mgmt-prod-log-wus2-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-wus2-001"
    }
  }
  rbac_role_definitions = [
    {
      name              = "Lock Contributor (Custom)"
      scope             = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      description       = "Create, edit or delete resource locks"
      actions           = ["Microsoft.Authorization/locks/*"]
      assignable_scopes = ["/providers/Microsoft.Management/managementGroups/jamietaffurelli"]
    }
  ]
  custom_rbac_role_assignments_service_principals = {
    "setup-landing-zones-tf-lockcont-org" = {
      service_principal_reference = "setup-landing-zones-tf"
      custom_role_reference       = "Lock Contributor (Custom)"
      scope                       = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
    }
  }
  log_analytics_workspace = {
    name                = "log-mgmt-prod-log-wus2-001"
    resource_group_name = "rg-mgmt-prod-log-wus2-001"
  }
}
