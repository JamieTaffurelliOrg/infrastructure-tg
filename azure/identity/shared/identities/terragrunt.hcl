terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-identity-tf///?ref=0.1.13"
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
    "conn-dev-afwp-tf" = {
      display_name = "conn-dev-afwp-tf"
      tags         = ["conn-dev-afwp-tf"]
    }
    "conn-prod-afwp-tf" = {
      display_name = "conn-prod-afwp-tf"
      tags         = ["conn-prod-afwp-tf"]
    }
    "conn-dev-afw-tf" = {
      display_name = "conn-dev-afw-tf"
      tags         = ["conn-dev-afw-tf"]
    }
    "conn-prod-afw-tf" = {
      display_name = "conn-prod-afw-tf"
      tags         = ["conn-prod-afw-tf"]
    }
    "conn-dev-fdfp-tf" = {
      display_name = "conn-dev-fdfp-tf"
      tags         = ["conn-dev-fdfp-tf"]
    }
    "conn-prod-fdfp-tf" = {
      display_name = "conn-prod-fdfp-tf"
      tags         = ["conn-prod-fdfp-tf"]
    }
    "conn-dev-afd-tf" = {
      display_name = "conn-dev-afd-tf"
      tags         = ["conn-dev-afd-tf"]
    }
    "conn-prod-afd-tf" = {
      display_name = "conn-prod-afd-tf"
      tags         = ["conn-prod-afd-tf"]
    }
    "app-dev-net-tf" = {
      display_name = "app-dev-net-tf"
      tags         = ["app-dev-net-tf"]
    }
    "app-prod-net-tf" = {
      display_name = "app-prod-net-tf"
      tags         = ["app-prod-net-tf"]
    }
    "app-dev-lb-tf" = {
      display_name = "app-dev-lb-tf"
      tags         = ["app-dev-lb-tf"]
    }
    "app-prod-lb-tf" = {
      display_name = "app-prod-lb-tf"
      tags         = ["app-prod-lb-tf"]
    }
    "mgmt-shrd-vmimg-tf" = {
      display_name = "mgmt-shrd-vmimg-tf"
      tags         = ["mgmt-shrd-vmimg-tf"]
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
    "conn-dev-afwp-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "conn-dev-afwp-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.dev.firewall-policy.deploy"
    }
    "conn-prod-afwp-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "conn-prod-afwp-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.prod.firewall-policy.deploy"
    }
    "conn-dev-afw-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "conn-dev-afw-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.dev.firewall.deploy"
    }
    "conn-prod-afw-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "conn-prod-afw-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.prod.firewall.deploy"
    }
    "conn-dev-fdfp-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "conn-dev-fdfp-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.dev.front-door-waf-policy.deploy"
    }
    "conn-prod-fdfp-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "conn-prod-fdfp-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.prod.front-door-waf-policy.deploy"
    }
    "conn-dev-afd-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "conn-dev-afd-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.dev.front-door.deploy"
    }
    "conn-prod-afd-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "conn-prod-afd-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:connectivity.prod.front-door.deploy"
    }
    "app-dev-net-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "app-dev-net-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.dev.network.deploy"
    }
    "app-prod-net-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "app-prod-net-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.prod.network.deploy"
    }
    "app-dev-lb-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "app-dev-lb-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.dev.load-balancer.deploy"
    }
    "app-prod-lb-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "app-prod-lb-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.prod.load-balancer.deploy"
    }
    "mgmt-shrd-vmimg-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "mgmt-shrd-vmimg-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:management.shared.vm-images.deploy"
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
    "conn-prod-bas-tf" = {
      application_id_reference = "conn-prod-bas-tf"
      description              = "Management of prod Bastion infrastructure via Terraform"
      tags                     = ["conn-prod-bas-tf"]
    }
    "conn-dev-afwp-tf" = {
      application_id_reference = "conn-dev-afwp-tf"
      description              = "Management of dev firewall policy infrastructure via Terraform"
      tags                     = ["conn-dev-afwp-tf"]
    }
    "conn-prod-afwp-tf" = {
      application_id_reference = "conn-prod-afwp-tf"
      description              = "Management of prod firewall policy infrastructure via Terraform"
      tags                     = ["conn-prod-afwp-tf"]
    }
    "conn-dev-afw-tf" = {
      application_id_reference = "conn-dev-afw-tf"
      description              = "Management of dev firewall policy infrastructure via Terraform"
      tags                     = ["conn-dev-afw-tf"]
    }
    "conn-prod-afw-tf" = {
      application_id_reference = "conn-prod-afw-tf"
      description              = "Management of prod firewall policy infrastructure via Terraform"
      tags                     = ["conn-prod-afw-tf"]
    }
    "conn-dev-fdfp-tf" = {
      application_id_reference = "conn-dev-fdfp-tf"
      description              = "Management of dev front door waf policy infrastructure via Terraform"
      tags                     = ["conn-dev-fdfp-tf"]
    }
    "conn-prod-fdfp-tf" = {
      application_id_reference = "conn-prod-fdfp-tf"
      description              = "Management of prod front door waf policy infrastructure via Terraform"
      tags                     = ["conn-prod-fdfp-tf"]
    }
    "conn-dev-afd-tf" = {
      application_id_reference = "conn-dev-afd-tf"
      description              = "Management of dev front door infrastructure via Terraform"
      tags                     = ["conn-dev-afd-tf"]
    }
    "conn-prod-afd-tf" = {
      application_id_reference = "conn-prod-afd-tf"
      description              = "Management of prod front door infrastructure via Terraform"
      tags                     = ["conn-prod-afd-tf"]
    }
    "app-dev-net-tf" = {
      application_id_reference = "app-dev-net-tf"
      description              = "Management of dev app network infrastructure via Terraform"
      tags                     = ["app-dev-net-tf"]
    }
    "app-prod-net-tf" = {
      application_id_reference = "app-prod-net-tf"
      description              = "Management of prod app network infrastructure via Terraform"
      tags                     = ["app-prod-net-tf"]
    }
    "app-dev-lb-tf" = {
      application_id_reference = "app-dev-lb-tf"
      description              = "Management of dev app load balancer infrastructure via Terraform"
      tags                     = ["app-dev-lb-tf"]
    }
    "app-prod-lb-tf" = {
      application_id_reference = "app-prod-lb-tf"
      description              = "Management of prod app load balancer infrastructure via Terraform"
      tags                     = ["app-prod-lb-tf"]
    }
    "mgmt-shrd-vmimg-tf" = {
      application_id_reference = "mgmt-shrd-vmimg-tf"
      description              = "Management of shared image gallery infrastructure via Terraform"
      tags                     = ["mgmt-shrd-vmimg-tf"]
    }
  }
  objects = {
    "galmgmtshrdvmimgwus2001" = {
      object_id = "9a518f10-dab1-403e-976d-db58976d3c3e"
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
    "conn-dev-hub-tf-moncontributor-mgmtdevlogs" = {
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
    "conn-dev-bas-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "conn-dev-bas-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/4593b317-03e9-4533-9f41-e0d4b6da338c/resourceGroups/rg-mgmt-dev-log-wus2-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-wus2-001"
    }
    "conn-dev-bas-tf-reader-conndevhub" = {
      service_principal_reference = "conn-dev-bas-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-hub-wus2-001"
    }
    "conn-dev-afwp-tf-contributor-conndevafwp" = {
      service_principal_reference = "conn-dev-afwp-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-afwp-wus2-001"
    }
    "conn-dev-afwp-tf-blobcontributor-conndevcontainer" = {
      service_principal_reference = "conn-dev-afwp-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-tf-frc1-001/providers/Microsoft.Storage/storageAccounts/stjtconndevtffrc1001/blobServices/default/containers/conn-dev"
    }
    "conn-dev-afwp-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "conn-dev-afwp-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/4593b317-03e9-4533-9f41-e0d4b6da338c/resourceGroups/rg-mgmt-dev-log-wus2-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-wus2-001"
    }
    "conn-dev-afw-tf-blobcontributor-conndevcontainer" = {
      service_principal_reference = "conn-dev-afw-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-tf-frc1-001/providers/Microsoft.Storage/storageAccounts/stjtconndevtffrc1001/blobServices/default/containers/conn-dev"
    }
    "conn-dev-afw-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "conn-dev-afw-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/4593b317-03e9-4533-9f41-e0d4b6da338c/resourceGroups/rg-mgmt-dev-log-wus2-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-wus2-001"
    }
    "conn-dev-afw-tf-reader-conndevhub" = {
      service_principal_reference = "conn-dev-afw-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-hub-wus2-001"
    }
    "conn-dev-afw-tf-reader-conndevafwp" = {
      service_principal_reference = "conn-dev-afw-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-afwp-wus2-001"
    }
    "conn-dev-fdfp-tf-blobcontributor-conndevcontainer" = {
      service_principal_reference = "conn-dev-fdfp-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-tf-frc1-001/providers/Microsoft.Storage/storageAccounts/stjtconndevtffrc1001/blobServices/default/containers/conn-dev"
    }
    "conn-dev-fdfp-tf-contributor-conndevafwp" = {
      service_principal_reference = "conn-dev-fdfp-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-fdfp-wus2-001"
    }
    "conn-dev-afd-tf-blobcontributor-conndevcontainer" = {
      service_principal_reference = "conn-dev-afd-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-tf-frc1-001/providers/Microsoft.Storage/storageAccounts/stjtconndevtffrc1001/blobServices/default/containers/conn-dev"
    }
    "conn-dev-afd-tf-contributor-conndevafd" = {
      service_principal_reference = "conn-dev-afd-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-afd-wus2-001"
    }
    "conn-dev-afd-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "conn-dev-afd-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/4593b317-03e9-4533-9f41-e0d4b6da338c/resourceGroups/rg-mgmt-dev-log-wus2-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-wus2-001"
    }
    "conn-dev-afd-tf-reader-conndevfdfp" = {
      service_principal_reference = "conn-dev-afd-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-fdfp-wus2-001"
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
    "conn-prod-bas-tf-contributor-connprodbas" = {
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
    "conn-prod-bas-tf-reader-connprodhub" = {
      service_principal_reference = "conn-prod-bas-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-hub-wus2-001"
    }
    "conn-prod-afwp-tf-contributor-connprodafwp" = {
      service_principal_reference = "conn-prod-afwp-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-afwp-wus2-001"
    }
    "conn-prod-afwp-tf-blobcontributor-connprodcontainer" = {
      service_principal_reference = "conn-prod-afwp-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-tf-frc1-001/providers/Microsoft.Storage/storageAccounts/stjtconnprodtffrc1001/blobServices/default/containers/conn-prod"
    }
    "conn-prod-afwp-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "conn-prod-afwp-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/510b35a4-6985-403e-939b-305da79e99bc/resourceGroups/rg-mgmt-prod-log-wus2-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-wus2-001"
    }
    "conn-prod-afw-tf-blobcontributor-connprodcontainer" = {
      service_principal_reference = "conn-prod-afw-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-tf-frc1-001/providers/Microsoft.Storage/storageAccounts/stjtconnprodtffrc1001/blobServices/default/containers/conn-prod"
    }
    "conn-prod-afw-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "conn-prod-afw-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/510b35a4-6985-403e-939b-305da79e99bc/resourceGroups/rg-mgmt-prod-log-wus2-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-wus2-001"
    }
    "conn-prod-afw-tf-reader-connprodhub" = {
      service_principal_reference = "conn-prod-afw-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-hub-wus2-001"
    }
    "conn-prod-afw-tf-reader-connprodafwp" = {
      service_principal_reference = "conn-prod-afw-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-afwp-wus2-001"
    }
    "conn-prod-fdfp-tf-blobcontributor-connprodcontainer" = {
      service_principal_reference = "conn-prod-fdfp-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-tf-frc1-001/providers/Microsoft.Storage/storageAccounts/stjtconnprodtffrc1001/blobServices/default/containers/conn-prod"
    }
    "conn-prod-fdfp-tf-contributor-hubrg" = {
      service_principal_reference = "conn-prod-fdfp-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-fdfp-wus2-001"
    }
    "conn-prod-afd-tf-blobcontributor-connprodcontainer" = {
      service_principal_reference = "conn-prod-afd-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-tf-frc1-001/providers/Microsoft.Storage/storageAccounts/stjtconnprodtffrc1001/blobServices/default/containers/conn-prod"
    }
    "conn-prod-afd-tf-contributor-connprodafd" = {
      service_principal_reference = "conn-prod-afd-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-afd-wus2-001"
    }
    "conn-prod-afd-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "conn-prod-afd-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/510b35a4-6985-403e-939b-305da79e99bc/resourceGroups/rg-mgmt-prod-log-wus2-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-wus2-001"
    }
    "conn-prod-afd-tf-reader-connprodfdfp" = {
      service_principal_reference = "conn-prod-afd-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-fdfp-wus2-001"
    }
    "app-dev-net-tf-contributor-appdevnet" = {
      service_principal_reference = "app-dev-net-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/e1806152-a836-4eed-b591-d76f6267b6d2/resourceGroups/rg-app-dev-net-wus2-001"
    }
    "app-dev-net-tf-blobcontributor-appdevcontainer" = {
      service_principal_reference = "app-dev-net-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/e1806152-a836-4eed-b591-d76f6267b6d2/resourceGroups/rg-app-dev-tf-frc1-001/providers/Microsoft.Storage/storageAccounts/stjtappdevtffrc1001/blobServices/default/containers/app-dev"
    }
    "app-dev-net-tf-prvdnscontributor-conndevprvdns" = {
      service_principal_reference = "app-dev-net-tf"
      role_definition_name        = "Private DNS Zone Contributor"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-prvdns-wus2-001"
    }
    "app-dev-net-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "app-dev-net-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/4593b317-03e9-4533-9f41-e0d4b6da338c/resourceGroups/rg-mgmt-dev-log-wus2-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-wus2-001"
    }
    "app-dev-net-tf-netcontributor-appdevnetwatcher" = {
      service_principal_reference = "app-dev-net-tf"
      role_definition_name        = "Network Contributor"
      scope                       = "/subscriptions/e1806152-a836-4eed-b591-d76f6267b6d2/resourceGroups/rg-app-dev-netwat-frc1-001/providers/Microsoft.Network/networkWatchers/nw-app-dev-netwat-wus2-001"
    }
    "app-dev-net-tf-reader-appdevsub" = {
      service_principal_reference = "app-dev-net-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/e1806152-a836-4eed-b591-d76f6267b6d2"
    }
    "app-dev-net-tf-contributor-mgmtdevlogs" = {
      service_principal_reference = "app-dev-net-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/4593b317-03e9-4533-9f41-e0d4b6da338c/resourceGroups/rg-mgmt-dev-log-wus2-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtdevlogwus2001"
    }
    "app-dev-lb-tf-contributor-appdevlb" = {
      service_principal_reference = "app-dev-lb-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/e1806152-a836-4eed-b591-d76f6267b6d2/resourceGroups/rg-app-dev-lb-wus2-001"
    }
    "app-dev-lb-tf-blobcontributor-appdevcontainer" = {
      service_principal_reference = "app-dev-lb-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/e1806152-a836-4eed-b591-d76f6267b6d2/resourceGroups/rg-app-dev-tf-frc1-001/providers/Microsoft.Storage/storageAccounts/stjtappdevtffrc1001/blobServices/default/containers/app-dev"
    }
    "app-dev-lb-tf-prvdnscontributor-conndevprvdns" = {
      service_principal_reference = "app-dev-lb-tf"
      role_definition_name        = "Private DNS Zone Contributor"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-prvdns-wus2-001"
    }
    "app-prod-net-tf-contributor-appprodnet" = {
      service_principal_reference = "app-prod-net-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/018499bc-61fd-4799-8107-d4ff6616527e/resourceGroups/rg-app-prod-net-wus2-001"
    }
    "app-prod-net-tf-blobcontributor-appprodcontainer" = {
      service_principal_reference = "app-prod-net-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/018499bc-61fd-4799-8107-d4ff6616527e/resourceGroups/rg-app-prod-tf-frc1-001/providers/Microsoft.Storage/storageAccounts/stjtappprodtffrc1001/blobServices/default/containers/app-prod"
    }
    "app-prod-net-tf-prvdnscontributor-conndevprvdns" = {
      service_principal_reference = "app-prod-net-tf"
      role_definition_name        = "Private DNS Zone Contributor"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-prvdns-wus2-001"
    }
    "app-prod-net-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "app-prod-net-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/510b35a4-6985-403e-939b-305da79e99bc/resourceGroups/rg-mgmt-prod-log-wus2-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-wus2-001"
    }
    "app-prod-net-tf-netcontributor-appprodnetwatcher" = {
      service_principal_reference = "app-prod-net-tf"
      role_definition_name        = "Network Contributor"
      scope                       = "/subscriptions/018499bc-61fd-4799-8107-d4ff6616527e/resourceGroups/rg-app-prod-netwat-frc1-001/providers/Microsoft.Network/networkWatchers/nw-app-prod-netwat-wus2-001"
    }
    "app-prod-net-tf-reader-appprodsub" = {
      service_principal_reference = "app-prod-net-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/018499bc-61fd-4799-8107-d4ff6616527e"
    }
    "app-prod-net-tf-contributor-mgmtprodlogstorage" = {
      service_principal_reference = "app-prod-net-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/510b35a4-6985-403e-939b-305da79e99bc/resourceGroups/rg-mgmt-prod-log-wus2-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtprodlogwus2001"
    }
    "app-prod-lb-tf-contributor-appprodlb" = {
      service_principal_reference = "app-prod-lb-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/018499bc-61fd-4799-8107-d4ff6616527e/resourceGroups/rg-app-prod-lb-wus2-001"
    }
    "app-prod-lb-tf-blobcontributor-appprodcontainer" = {
      service_principal_reference = "app-prod-lb-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/018499bc-61fd-4799-8107-d4ff6616527e/resourceGroups/rg-app-prod-tf-frc1-001/providers/Microsoft.Storage/storageAccounts/stjtappprodtffrc1001/blobServices/default/containers/app-prod"
    }
    "app-prod-lb-tf-prvdnscontributor-conndevprvdns" = {
      service_principal_reference = "app-prod-lb-tf"
      role_definition_name        = "Private DNS Zone Contributor"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-prvdns-wus2-001"
    }
    "mgmt-shrd-vmimg-tf-contributor-mgmtshrdvmimg" = {
      service_principal_reference = "mgmt-shrd-vmimg-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/a9da0406-a642-49b3-9c2c-c8ed05bb1c85/resourceGroups/rg-mgmt-shrd-vmimg-wus2-001"
    }
    "mgmt-shrd-vmimg-tf-blobcontributor-mgmtshrdcontainer" = {
      service_principal_reference = "mgmt-shrd-vmimg-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/a9da0406-a642-49b3-9c2c-c8ed05bb1c85/resourceGroups/rg-mgmt-shrd-tf-frc1-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtshrdtffrc1001/blobServices/default/containers/mgmt-shrd"
    }
    "mgmt-shrd-net-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "mgmt-shrd-net-tf"
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
    },
    {
      name              = "Public IP Prefix Joiner (Custom)"
      scope             = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      description       = "Attach public IP addresses to public IP prefixes"
      actions           = ["Microsoft.Network/publicIPPrefixes/join/action"]
      assignable_scopes = ["/providers/Microsoft.Management/managementGroups/jamietaffurelli"]
    },
    {
      name              = "Subnet Joiner (Custom)"
      scope             = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      description       = "Attach resources to subnets"
      actions           = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/joinLoadBalancer/action", "Microsoft.Network/virtualNetworks/subnets/joinViaServiceEndpoint/action", "Microsoft.Network/virtualNetworks/subnets/joinLoadBalancer/action", "Microsoft.Network/virtualNetworks/*/read"]
      assignable_scopes = ["/providers/Microsoft.Management/managementGroups/jamietaffurelli"]
    },
    {
      name              = "Firewall Policy Joiner (Custom)"
      scope             = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      description       = "Attach firewalls to firewall policies"
      actions           = ["Microsoft.Network/firewallPolicies/join/action"]
      assignable_scopes = ["/providers/Microsoft.Management/managementGroups/jamietaffurelli"]
    },
    {
      name              = "Firewall Contributor (Custom)"
      scope             = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      description       = "Create and delete Azure Firewalls"
      actions           = ["Microsoft.Network/azureFirewalls/*", "Microsoft.Network/publicIPAddresses/*", "Microsoft.Insights/diagnosticSettings/*"]
      assignable_scopes = ["/providers/Microsoft.Management/managementGroups/jamietaffurelli"]
    },
    {
      name        = "Image Creator (Custom)"
      scope       = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      description = "Create and delete Azure Firewalls"
      actions = [
        "Microsoft.Compute/galleries/read",
        "Microsoft.Compute/galleries/images/read",
        "Microsoft.Compute/galleries/images/versions/read",
        "Microsoft.Compute/galleries/images/versions/write",
        "Microsoft.Compute/images/write",
        "Microsoft.Compute/images/read",
        "Microsoft.Compute/images/delete"
      ]
      assignable_scopes = ["/providers/Microsoft.Management/managementGroups/jamietaffurelli"]
    }
  ]
  custom_rbac_role_assignments_service_principals = {
    "setup-landing-zones-tf-lockcont-org" = {
      service_principal_reference = "setup-landing-zones-tf"
      custom_role_reference       = "Lock Contributor (Custom)"
      scope                       = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
    }
    "conn-dev-bas-tf-prefixjoin-conndevhubprefix" = {
      service_principal_reference = "conn-dev-bas-tf"
      custom_role_reference       = "Public IP Prefix Joiner (Custom)"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-hub-wus2-001/providers/Microsoft.Network/publicIPPrefixes/ippre-conn-dev-hub-wus2-001"
    }
    "conn-dev-bas-tf-subnetjoin-conndevhubsubnet" = {
      service_principal_reference = "conn-dev-bas-tf"
      custom_role_reference       = "Subnet Joiner (Custom)"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-hub-wus2-001/providers/Microsoft.Network/virtualNetworks/vnet-conn-dev-hub-wus2-001/subnets/AzureBastionSubnet"
    }
    "conn-dev-afw-tf-prefixjoin-conndevhubprefix" = {
      service_principal_reference = "conn-dev-afw-tf"
      custom_role_reference       = "Public IP Prefix Joiner (Custom)"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-hub-wus2-001/providers/Microsoft.Network/publicIPPrefixes/ippre-conn-dev-hub-wus2-001"
    }
    "conn-dev-afw-tf-subnetjoin-conndevhubsubnet" = {
      service_principal_reference = "conn-dev-afw-tf"
      custom_role_reference       = "Subnet Joiner (Custom)"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-hub-wus2-001/providers/Microsoft.Network/virtualNetworks/vnet-conn-dev-hub-wus2-001/subnets/AzureFirewallSubnet"
    }
    "conn-dev-afw-tf-fwpoljoin-conndevfwpol" = {
      service_principal_reference = "conn-dev-afw-tf"
      custom_role_reference       = "Firewall Policy Joiner (Custom)"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-afwp-wus2-001/providers/Microsoft.Network/firewallPolicies/afwp-conn-dev-afwp-wus2-001"
    }
    "conn-dev-afw-tf-fwcont-conndevhub" = {
      service_principal_reference = "conn-dev-afw-tf"
      custom_role_reference       = "Firewall Contributor (Custom)"
      scope                       = "/subscriptions/58b4ad6f-a160-4b9e-841b-e177f66137c9/resourceGroups/rg-conn-dev-hub-wus2-001"
    }
    "conn-prod-bas-tf-prefixjoin-connprodhubprefix" = {
      service_principal_reference = "conn-prod-bas-tf"
      custom_role_reference       = "Public IP Prefix Joiner (Custom)"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-hub-wus2-001/providers/Microsoft.Network/publicIPPrefixes/ippre-conn-prod-hub-wus2-001"
    }
    "conn-prod-bas-tf-subnetjoin-connprodhubsubnet" = {
      service_principal_reference = "conn-prod-bas-tf"
      custom_role_reference       = "Subnet Joiner (Custom)"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-hub-wus2-001/providers/Microsoft.Network/virtualNetworks/vnet-conn-prod-hub-wus2-001/subnets/AzureFirewallSubnet"
    }
    "conn-prod-afw-tf-prefixjoin-connprodhubprefix" = {
      service_principal_reference = "conn-prod-afw-tf"
      custom_role_reference       = "Public IP Prefix Joiner (Custom)"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-hub-wus2-001/providers/Microsoft.Network/publicIPPrefixes/ippre-conn-prod-hub-wus2-001"
    }
    "conn-prod-afw-tf-subnetjoin-connprodhubsubnet" = {
      service_principal_reference = "conn-prod-afw-tf"
      custom_role_reference       = "Subnet Joiner (Custom)"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-hub-wus2-001/providers/Microsoft.Network/virtualNetworks/vnet-conn-prod-hub-wus2-001/subnets/AzureBastionSubnet"
    }
    "conn-prod-afw-tf-fwpoljoin-connprodfwpol" = {
      service_principal_reference = "conn-prod-afw-tf"
      custom_role_reference       = "Firewall Policy Joiner (Custom)"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-afwp-wus2-001/providers/Microsoft.Network/firewallPolicies/afwp-conn-prod-afwp-wus2-001"
    }
    "conn-prod-afw-tf-fwcont-connprodhub" = {
      service_principal_reference = "conn-prod-afw-tf"
      custom_role_reference       = "Firewall Contributor (Custom)"
      scope                       = "/subscriptions/9689d784-a98b-49f0-8601-43a18ce83ab4/resourceGroups/rg-conn-prod-hub-wus2-001"
    }
    "app-dev-lb-tf-subnetjoin-appdevnet" = {
      service_principal_reference = "app-dev-lb-tf"
      custom_role_reference       = "Subnet Joiner (Custom)"
      scope                       = "/subscriptions/e1806152-a836-4eed-b591-d76f6267b6d2/resourceGroups/rg-app-dev-net-wus2-001/providers/Microsoft.Network/virtualNetworks/vnet-app-dev-net-wus2-001"
    }
    "app-prod-lb-tf-subnetjoin-appprodnet" = {
      service_principal_reference = "app-prod-lb-tf"
      custom_role_reference       = "Subnet Joiner (Custom)"
      scope                       = "/subscriptions/018499bc-61fd-4799-8107-d4ff6616527e/resourceGroups/rg-app-prod-net-wus2-001/providers/Microsoft.Network/virtualNetworks/vnet-app-prod-net-wus2-001"
    }
  }
  custom_rbac_role_assignments_objects = {
    "galmgmtshrdvmimgwus2001-imgbuilder" = {
      object_reference      = "galmgmtshrdvmimgwus2001"
      custom_role_reference = "Image Creator (Custom)"
      scope                 = "/subscriptions/a9da0406-a642-49b3-9c2c-c8ed05bb1c85/resourceGroups/rg-mgmt-shrd-vmimg-wus2-001/providers/Microsoft.Compute/galleries/galmgmtshrdvmimgwus2001"
    }
  }
  log_analytics_workspace = {
    name                = "log-mgmt-prod-log-wus2-001"
    resource_group_name = "rg-mgmt-prod-log-wus2-001"
  }
}
