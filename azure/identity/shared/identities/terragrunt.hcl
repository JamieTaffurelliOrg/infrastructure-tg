terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-identity-tf///?ref=0.1.15"
}

include {
  path = find_in_parent_folders()
}

locals {

}

inputs = {

  applications = {
    "aws-sso" = {
      display_name = "AWS Single Sign-On"
      tags         = ["AWS", "SSO", "WindowsAzureActiveDirectoryIntegratedApp", "WindowsAzureActiveDirectoryCustomSingleSignOnApplication"]
    }
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
    "app-dev-web-tf" = {
      display_name = "app-dev-web-tf"
      tags         = ["app-dev-web-tf"]
    }
    "app-dev-sql-tf" = {
      display_name = "app-dev-sql-tf"
      tags         = ["app-dev-sql-tf"]
    }
    "app-dev-kv-tf" = {
      display_name = "app-dev-kv-tf"
      tags         = ["app-dev-kv-tf"]
    }
    "app-dev-redis-tf" = {
      display_name = "app-dev-redis-tf"
      tags         = ["app-dev-redis-tf"]
    }
    "app-prod-lb-tf" = {
      display_name = "app-prod-lb-tf"
      tags         = ["app-prod-lb-tf"]
    }
    "app-prod-web-tf" = {
      display_name = "app-prod-web-tf"
      tags         = ["app-prod-web-tf"]
    }
    "app-prod-sql-tf" = {
      display_name = "app-prod-sql-tf"
      tags         = ["app-prod-sql-tf"]
    }
    "app-prod-kv-tf" = {
      display_name = "app-prod-kv-tf"
      tags         = ["app-prod-kv-tf"]
    }
    "mgmt-shrd-vmimg-tf" = {
      display_name = "mgmt-shrd-vmimg-tf"
      tags         = ["mgmt-shrd-vmimg-tf"]
    }
    "vm-scripts" = {
      display_name = "vm-scripts"
      tags         = ["vm-scripts"]
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
    "app-dev-web-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "app-dev-web-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.dev.web-server.deploy"
    }
    "app-dev-sql-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "app-dev-sql-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.dev.sql-server.deploy"
    }
    "app-dev-kv-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "app-dev-kv-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.dev.key-vault.deploy"
    }
    "app-dev-redis-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "app-dev-redis-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.dev.redis.deploy"
    }
    "app-prod-lb-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "app-prod-lb-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.prod.load-balancer.deploy"
    }
    "app-prod-web-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "app-prod-web-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.prod.web-server.deploy"
    }
    "app-prod-sql-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "app-prod-sql-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.prod.sql-server.deploy"
    }
    "app-prod-kv-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "app-prod-kv-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:app.prod.key-vault.deploy"
    }
    "mgmt-shrd-vmimg-tf-deploy" = {
      display_name             = "deploy"
      application_id_reference = "mgmt-shrd-vmimg-tf"
      description              = "Authentication for GitHub Actions deployment"
      issuer                   = "https://token.actions.githubusercontent.com"
      subject                  = "repo:JamieTaffurelliOrg/infrastructure-tg:environment:management.shared.vm-images.deploy"
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
    "aws-sso" = {
      application_id_reference = "aws-sso"
      description              = "AWS Single Sign-On"
      tags                     = ["AWS", "SSO", "WindowsAzureActiveDirectoryIntegratedApp", "WindowsAzureActiveDirectoryCustomSingleSignOnApplication"]
    }
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
    "app-dev-lb-tf" = {
      application_id_reference = "app-dev-lb-tf"
      description              = "Management of dev app load balancer infrastructure via Terraform"
      tags                     = ["app-dev-lb-tf"]
    }
    "app-dev-web-tf" = {
      application_id_reference = "app-dev-web-tf"
      description              = "Management of dev app web server infrastructure via Terraform"
      tags                     = ["app-dev-web-tf"]
    }
    "app-dev-sql-tf" = {
      application_id_reference = "app-dev-sql-tf"
      description              = "Management of dev app sql server infrastructure via Terraform"
      tags                     = ["app-dev-sql-tf"]
    }
    "app-dev-kv-tf" = {
      application_id_reference = "app-dev-kv-tf"
      description              = "Management of dev app key vault infrastructure via Terraform"
      tags                     = ["app-dev-kv-tf"]
    }
    "app-dev-redis-tf" = {
      application_id_reference = "app-dev-redis-tf"
      description              = "Management of dev app redis infrastructure via Terraform"
      tags                     = ["app-dev-redis-tf"]
    }
    "app-prod-net-tf" = {
      application_id_reference = "app-prod-net-tf"
      description              = "Management of prod app network infrastructure via Terraform"
      tags                     = ["app-prod-net-tf"]
    }
    "app-prod-lb-tf" = {
      application_id_reference = "app-prod-lb-tf"
      description              = "Management of prod app load balancer infrastructure via Terraform"
      tags                     = ["app-prod-lb-tf"]
    }
    "app-prod-web-tf" = {
      application_id_reference = "app-prod-web-tf"
      description              = "Management of dev app web server infrastructure via Terraform"
      tags                     = ["app-prod-web-tf"]
    }
    "app-prod-sql-tf" = {
      application_id_reference = "app-prod-sql-tf"
      description              = "Management of dev app sql server infrastructure via Terraform"
      tags                     = ["app-prod-sql-tf"]
    }
    "app-prod-kv-tf" = {
      application_id_reference = "app-prod-kv-tf"
      description              = "Management of prod app key vault infrastructure via Terraform"
      tags                     = ["app-prod-kv-tf"]
    }
    "mgmt-shrd-vmimg-tf" = {
      application_id_reference = "mgmt-shrd-vmimg-tf"
      description              = "Management of shared image gallery infrastructure via Terraform"
      tags                     = ["mgmt-shrd-vmimg-tf"]
    }
    "vm-scripts" = {
      application_id_reference = "vm-scripts"
      description              = "Deployment of scripts used for VM configuration to storage account"
      tags                     = ["vm-scripts"]
    }
  }
  objects = {
    "galmgmtshrdvmimgweu1001" = {
      object_id = "e908d88a-f0c7-4719-8978-b8626e88c7f4"
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
      scope                       = "/subscriptions/625faac3-7208-4816-8899-7e546d0e830b/resourceGroups/rg-stp-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtstpprodtfweu1001/blobServices/default/containers/setup-prod"
    }
    "github-tf-blobcontributor-githubcontainer" = {
      service_principal_reference = "github-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/cac174dc-d598-40ea-857d-8cb88c823031/resourceGroups/rg-tfext-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjttfextpprodtfweu1001/blobServices/default/containers/github"
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
      scope                       = "/subscriptions/97f65cdf-6be6-4e62-b0d2-a4b985a8f047/resourceGroups/rg-iden-shrd-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtidenshrdtfweu1001/blobServices/default/containers/iden-shrd"
    }
    "identity-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "identity-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/354a71d2-11ed-4c91-abb2-a08a2b4abe69/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "mgmt-dev-logging-tf-blobcontributor-mgmtdevcontainer" = {
      service_principal_reference = "mgmt-dev-logging-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/9661faf5-39f5-400b-931a-342f9240c71b/resourceGroups/rg-mgmt-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtdevtfweu1001/blobServices/default/containers/mgmt-dev"
    }
    "mgmt-dev-logging-tf-contributor-loggingrg" = {
      service_principal_reference = "mgmt-dev-logging-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/9661faf5-39f5-400b-931a-342f9240c71b/resourceGroups/rg-mgmt-dev-log-weu1-001"
    }
    "mgmt-prod-logging-tf-blobcontributor-mgmtprodcontainer" = {
      service_principal_reference = "mgmt-prod-logging-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/354a71d2-11ed-4c91-abb2-a08a2b4abe69/resourceGroups/rg-mgmt-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtprodtfweu1001/blobServices/default/containers/mgmt-prod"
    }
    "mgmt-prod-logging-tf-contributor-loggingrg" = {
      service_principal_reference = "mgmt-prod-logging-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/354a71d2-11ed-4c91-abb2-a08a2b4abe69/resourceGroups/rg-mgmt-prod-log-weu1-001"
    }
    "conn-dev-hub-tf-blobcontributor-conndevcontainer" = {
      service_principal_reference = "conn-dev-hub-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconndevtfweu1001/blobServices/default/containers/conn-dev"
    }
    "conn-dev-hub-tf-contributor-hubrg" = {
      service_principal_reference = "conn-dev-hub-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-hub-weu1-001"
    }
    "conn-dev-hub-tf-reader-sub" = {
      service_principal_reference = "conn-dev-hub-tf"
      role_definition_name        = "Reader"
      scope                       = "/providers/Microsoft.Subscription"
    }
    "conn-dev-hub-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "conn-dev-hub-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/9661faf5-39f5-400b-931a-342f9240c71b/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "conn-dev-hub-tf-contributor-mgmtdevlogstorage" = {
      service_principal_reference = "conn-dev-hub-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/9661faf5-39f5-400b-931a-342f9240c71b/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtdevlogweu1002"
    }
    "conn-dev-hub-tf-netcontributor-conndevnetwatcher" = {
      service_principal_reference = "conn-dev-hub-tf"
      role_definition_name        = "Network Contributor"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-netwat-weu1-001/providers/Microsoft.Network/networkWatchers/nw-conn-dev-netwat-weu1-001"
    }
    "conn-dev-hub-tf-reader-conndevsub" = {
      service_principal_reference = "conn-dev-hub-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90"
    }
    "conn-dev-hub-tf-reader-appdevsub" = {
      service_principal_reference = "conn-dev-hub-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241"
    }
    "conn-dev-hub-tf-prvdnscontributor-conndevprvdns" = {
      service_principal_reference = "conn-dev-hub-tf"
      role_definition_name        = "Private DNS Zone Contributor"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-prvdns-weu1-001"
    }
    "conn-dev-prvdns-tf-contributor-conndevprvdns" = {
      service_principal_reference = "conn-dev-prvdns-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-prvdns-weu1-001"
    }
    "conn-dev-prvdns-tf-blobcontributor-conndevcontainer" = {
      service_principal_reference = "conn-dev-prvdns-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconndevtfweu1001/blobServices/default/containers/conn-dev"
    }
    "conn-dev-bas-tf-contributor-conndevbas" = {
      service_principal_reference = "conn-dev-bas-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-bas-weu1-001"
    }
    "conn-dev-bas-tf-blobcontributor-conndevcontainer" = {
      service_principal_reference = "conn-dev-bas-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconndevtfweu1001/blobServices/default/containers/conn-dev"
    }
    "conn-dev-bas-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "conn-dev-bas-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/9661faf5-39f5-400b-931a-342f9240c71b/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "conn-dev-bas-tf-reader-conndevhub" = {
      service_principal_reference = "conn-dev-bas-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-hub-weu1-001"
    }
    "conn-dev-afwp-tf-contributor-conndevafwp" = {
      service_principal_reference = "conn-dev-afwp-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-afwp-weu1-001"
    }
    "conn-dev-afwp-tf-blobcontributor-conndevcontainer" = {
      service_principal_reference = "conn-dev-afwp-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconndevtfweu1001/blobServices/default/containers/conn-dev"
    }
    "conn-dev-afwp-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "conn-dev-afwp-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/9661faf5-39f5-400b-931a-342f9240c71b/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "conn-dev-afw-tf-blobcontributor-conndevcontainer" = {
      service_principal_reference = "conn-dev-afw-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconndevtfweu1001/blobServices/default/containers/conn-dev"
    }
    "conn-dev-afw-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "conn-dev-afw-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/9661faf5-39f5-400b-931a-342f9240c71b/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "conn-dev-afw-tf-reader-conndevhub" = {
      service_principal_reference = "conn-dev-afw-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-hub-weu1-001"
    }
    "conn-dev-afw-tf-reader-conndevafwp" = {
      service_principal_reference = "conn-dev-afw-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-afwp-weu1-001"
    }
    "conn-dev-fdfp-tf-blobcontributor-conndevcontainer" = {
      service_principal_reference = "conn-dev-fdfp-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconndevtfweu1001/blobServices/default/containers/conn-dev"
    }
    "conn-dev-fdfp-tf-contributor-conndevafwp" = {
      service_principal_reference = "conn-dev-fdfp-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-fdfp-weu1-001"
    }
    "conn-dev-afd-tf-blobcontributor-conndevcontainer" = {
      service_principal_reference = "conn-dev-afd-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconndevtfweu1001/blobServices/default/containers/conn-dev"
    }
    "conn-dev-afd-tf-contributor-conndevafd" = {
      service_principal_reference = "conn-dev-afd-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-afd-weu1-001"
    }
    "conn-dev-afd-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "conn-dev-afd-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/9661faf5-39f5-400b-931a-342f9240c71b/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "conn-dev-afd-tf-reader-conndevfdfp" = {
      service_principal_reference = "conn-dev-afd-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-fdfp-weu1-001"
    }
    "conn-prod-hub-tf-blobcontributor-connprodcontainer" = {
      service_principal_reference = "conn-prod-hub-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconnprodtfweu1001/blobServices/default/containers/conn-prod"
    }
    "conn-prod-hub-tf-contributor-hubrg" = {
      service_principal_reference = "conn-prod-hub-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-hub-weu1-001"
    }
    "conn-prod-hub-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "conn-prod-hub-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/354a71d2-11ed-4c91-abb2-a08a2b4abe69/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "conn-prod-hub-tf-contributor-mgmtprodlogstorage" = {
      service_principal_reference = "conn-prod-hub-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/354a71d2-11ed-4c91-abb2-a08a2b4abe69/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtprodlogweu1002"
    }
    "conn-prod-hub-tf-netcontributor-connprodnetwatcher" = {
      service_principal_reference = "conn-prod-hub-tf"
      role_definition_name        = "Network Contributor"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-netwat-weu1-001/providers/Microsoft.Network/networkWatchers/nw-conn-prod-netwat-weu1-001"
    }
    "conn-prod-hub-tf-reader-conprodsub" = {
      service_principal_reference = "conn-prod-hub-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66"
    }
    "conn-prod-hub-tf-reader-appprodsub" = {
      service_principal_reference = "conn-prod-hub-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/f4722c2d-47d5-4513-a562-80465e3ee813"
    }
    "conn-prod-hub-tf-prvdnscontributor-conndevprvdns" = {
      service_principal_reference = "conn-prod-hub-tf"
      role_definition_name        = "Private DNS Zone Contributor"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-prvdns-weu1-001"
    }
    "conn-prod-prvdns-tf-contributor-connprodprvdns" = {
      service_principal_reference = "conn-prod-prvdns-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-prvdns-weu1-001"
    }
    "conn-prod-prvdns-tf-blobcontributor-connprodcontainer" = {
      service_principal_reference = "conn-prod-prvdns-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconnprodtfweu1001/blobServices/default/containers/conn-prod"
    }
    "conn-prod-bas-tf-contributor-connprodbas" = {
      service_principal_reference = "conn-prod-bas-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-bas-weu1-001"
    }
    "conn-prod-bas-tf-blobcontributor-connprodcontainer" = {
      service_principal_reference = "conn-prod-bas-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconnprodtfweu1001/blobServices/default/containers/conn-prod"
    }
    "conn-prod-bas-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "conn-prod-bas-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/354a71d2-11ed-4c91-abb2-a08a2b4abe69/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "conn-prod-bas-tf-reader-connprodhub" = {
      service_principal_reference = "conn-prod-bas-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-hub-weu1-001"
    }
    "conn-prod-afwp-tf-contributor-connprodafwp" = {
      service_principal_reference = "conn-prod-afwp-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-afwp-weu1-001"
    }
    "conn-prod-afwp-tf-blobcontributor-connprodcontainer" = {
      service_principal_reference = "conn-prod-afwp-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconnprodtfweu1001/blobServices/default/containers/conn-prod"
    }
    "conn-prod-afwp-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "conn-prod-afwp-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/354a71d2-11ed-4c91-abb2-a08a2b4abe69/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "conn-prod-afw-tf-blobcontributor-connprodcontainer" = {
      service_principal_reference = "conn-prod-afw-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconnprodtfweu1001/blobServices/default/containers/conn-prod"
    }
    "conn-prod-afw-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "conn-prod-afw-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/354a71d2-11ed-4c91-abb2-a08a2b4abe69/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "conn-prod-afw-tf-reader-connprodhub" = {
      service_principal_reference = "conn-prod-afw-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-hub-weu1-001"
    }
    "conn-prod-afw-tf-reader-connprodafwp" = {
      service_principal_reference = "conn-prod-afw-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-afwp-weu1-001"
    }
    "conn-prod-fdfp-tf-blobcontributor-connprodcontainer" = {
      service_principal_reference = "conn-prod-fdfp-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconnprodtfweu1001/blobServices/default/containers/conn-prod"
    }
    "conn-prod-fdfp-tf-contributor-hubrg" = {
      service_principal_reference = "conn-prod-fdfp-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-fdfp-weu1-001"
    }
    "conn-prod-afd-tf-blobcontributor-connprodcontainer" = {
      service_principal_reference = "conn-prod-afd-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtconnprodtfweu1001/blobServices/default/containers/conn-prod"
    }
    "conn-prod-afd-tf-contributor-connprodafd" = {
      service_principal_reference = "conn-prod-afd-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-afd-weu1-001"
    }
    "conn-prod-afd-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "conn-prod-afd-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/354a71d2-11ed-4c91-abb2-a08a2b4abe69/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "conn-prod-afd-tf-reader-connprodfdfp" = {
      service_principal_reference = "conn-prod-afd-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-fdfp-weu1-001"
    }
    "app-dev-net-tf-contributor-appdevnet" = {
      service_principal_reference = "app-dev-net-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-net-weu1-001"
    }
    "app-dev-net-tf-blobcontributor-appdevcontainer" = {
      service_principal_reference = "app-dev-net-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappdevtfweu1001/blobServices/default/containers/app-dev"
    }
    "app-dev-net-tf-prvdnscontributor-conndevprvdns" = {
      service_principal_reference = "app-dev-net-tf"
      role_definition_name        = "Private DNS Zone Contributor"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-prvdns-weu1-001"
    }
    "app-dev-net-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "app-dev-net-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/9661faf5-39f5-400b-931a-342f9240c71b/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "app-dev-net-tf-netcontributor-appdevnetwatcher" = {
      service_principal_reference = "app-dev-net-tf"
      role_definition_name        = "Network Contributor"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-netwat-weu1-001/providers/Microsoft.Network/networkWatchers/nw-app-dev-netwat-weu1-001"
    }
    "app-dev-net-tf-reader-appdevsub" = {
      service_principal_reference = "app-dev-net-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241"
    }
    "app-dev-net-tf-contributor-mgmtdevlogs" = {
      service_principal_reference = "app-dev-net-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/9661faf5-39f5-400b-931a-342f9240c71b/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtdevlogweu1002"
    }
    "app-dev-lb-tf-contributor-appdevlb" = {
      service_principal_reference = "app-dev-lb-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-lb-weu1-001"
    }
    "app-dev-lb-tf-blobcontributor-appdevcontainer" = {
      service_principal_reference = "app-dev-lb-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappdevtfweu1001/blobServices/default/containers/app-dev"
    }
    "app-dev-lb-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "app-dev-lb-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/9661faf5-39f5-400b-931a-342f9240c71b/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "app-dev-web-tf-contributor-appdevweb" = {
      service_principal_reference = "app-dev-web-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-web-weu1-001"
    }
    "app-dev-web-tf-blobcontributor-appdevcontainer" = {
      service_principal_reference = "app-dev-web-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappdevtfweu1001/blobServices/default/containers/app-dev"
    }
    "app-dev-web-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "app-dev-web-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/9661faf5-39f5-400b-931a-342f9240c71b/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "app-dev-web-tf-contributor-appdevdiag" = {
      service_principal_reference = "app-dev-web-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-diag-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappdevdiagweu1002"
    }
    "app-dev-web-tf-reader-mgmtshrdimg" = {
      service_principal_reference = "app-dev-web-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/3bdf403f-77ac-4879-8fba-fa41c2cc94ee/resourceGroups/rg-mgmt-shrd-vmimg-weu1-001"
    }
    "app-dev-web-tf-kvadmin-appdevkv" = {
      service_principal_reference = "app-dev-web-tf"
      role_definition_name        = "Key Vault Administrator"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-kv-weu1-001/providers/Microsoft.KeyVault/vaults/kv-app-dev-kv-weu1-002"
    }
    "app-dev-web-tf-reader-appdevlb" = {
      service_principal_reference = "app-dev-web-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-lb-weu1-001"
    }
    "app-dev-sql-tf-contributor-appdevsql" = {
      service_principal_reference = "app-dev-sql-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-sql-weu1-001"
    }
    "app-dev-sql-tf-blobcontributor-appdevcontainer" = {
      service_principal_reference = "app-dev-sql-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappdevtfweu1001/blobServices/default/containers/app-dev"
    }
    "app-dev-sql-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "app-dev-sql-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/9661faf5-39f5-400b-931a-342f9240c71b/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "app-dev-sql-tf-contributor-appdevdiag" = {
      service_principal_reference = "app-dev-sql-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-diag-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappdevdiagweu1002"
    }
    "app-dev-sql-tf-reader-mgmtshrdimg" = {
      service_principal_reference = "app-dev-sql-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/3bdf403f-77ac-4879-8fba-fa41c2cc94ee/resourceGroups/rg-mgmt-shrd-vmimg-weu1-001"
    }
    "app-dev-sql-tf-kvadmin-appdevkv" = {
      service_principal_reference = "app-dev-sql-tf"
      role_definition_name        = "Key Vault Administrator"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-kv-weu1-001/providers/Microsoft.KeyVault/vaults/kv-app-dev-kv-weu1-002"
    }
    "app-dev-kv-tf-contributor-appdevkv" = {
      service_principal_reference = "app-dev-kv-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-kv-weu1-001"
    }
    "app-dev-kv-tf-blobcontributor-appdevcontainer" = {
      service_principal_reference = "app-dev-kv-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappdevtfweu1001/blobServices/default/containers/app-dev-kv"
    }
    "app-dev-kv-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "app-dev-kv-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/9661faf5-39f5-400b-931a-342f9240c71b/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "app-dev-redis-tf-contributor-appdevredis" = {
      service_principal_reference = "app-dev-redis-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-redis-weu1-001"
    }
    "app-dev-redis-tf-blobcontributor-appdevcontainer" = {
      service_principal_reference = "app-dev-redis-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappdevtfweu1001/blobServices/default/containers/app-dev"
    }
    "app-dev-redis-tf-moncontributor-mgmtdevlogs" = {
      service_principal_reference = "app-dev-redis-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/9661faf5-39f5-400b-931a-342f9240c71b/resourceGroups/rg-mgmt-dev-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-dev-log-weu1-001"
    }
    "app-dev-redis-tf-prvdnscontributor-conndevprvdns" = {
      service_principal_reference = "app-dev-redis-tf"
      role_definition_name        = "Private DNS Zone Contributor"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-prvdns-weu1-001"
    }
    "app-prod-net-tf-contributor-appprodnet" = {
      service_principal_reference = "app-prod-net-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/f4722c2d-47d5-4513-a562-80465e3ee813/resourceGroups/rg-app-prod-net-weu1-001"
    }
    "app-prod-net-tf-blobcontributor-appprodcontainer" = {
      service_principal_reference = "app-prod-net-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/f4722c2d-47d5-4513-a562-80465e3ee813/resourceGroups/rg-app-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappprodtfweu1001/blobServices/default/containers/app-prod"
    }
    "app-prod-net-tf-prvdnscontributor-conndevprvdns" = {
      service_principal_reference = "app-prod-net-tf"
      role_definition_name        = "Private DNS Zone Contributor"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-prvdns-weu1-001"
    }
    "app-prod-net-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "app-prod-net-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/354a71d2-11ed-4c91-abb2-a08a2b4abe69/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "app-prod-net-tf-netcontributor-appprodnetwatcher" = {
      service_principal_reference = "app-prod-net-tf"
      role_definition_name        = "Network Contributor"
      scope                       = "/subscriptions/f4722c2d-47d5-4513-a562-80465e3ee813/resourceGroups/rg-app-prod-netwat-weu1-001/providers/Microsoft.Network/networkWatchers/nw-app-prod-netwat-weu1-001"
    }
    "app-prod-net-tf-reader-appprodsub" = {
      service_principal_reference = "app-prod-net-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/f4722c2d-47d5-4513-a562-80465e3ee813"
    }
    "app-prod-net-tf-contributor-mgmtprodlogstorage" = {
      service_principal_reference = "app-prod-net-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/354a71d2-11ed-4c91-abb2-a08a2b4abe69/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtprodlogweu1002"
    }
    "app-prod-lb-tf-contributor-appprodlb" = {
      service_principal_reference = "app-prod-lb-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/f4722c2d-47d5-4513-a562-80465e3ee813/resourceGroups/rg-app-prod-lb-weu1-001"
    }
    "app-prod-lb-tf-blobcontributor-appprodcontainer" = {
      service_principal_reference = "app-prod-lb-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/f4722c2d-47d5-4513-a562-80465e3ee813/resourceGroups/rg-app-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappprodtfweu1001/blobServices/default/containers/app-prod"
    }
    "app-prod-lb-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "app-prod-lb-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/354a71d2-11ed-4c91-abb2-a08a2b4abe69/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "app-prod-web-tf-contributor-appprodweb" = {
      service_principal_reference = "app-prod-web-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/f4722c2d-47d5-4513-a562-80465e3ee813/resourceGroups/rg-app-prod-web-weu1-001"
    }
    "app-prod-web-tf-blobcontributor-appprodcontainer" = {
      service_principal_reference = "app-prod-web-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/f4722c2d-47d5-4513-a562-80465e3ee813/resourceGroups/rg-app-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappprodtfweu1001/blobServices/default/containers/app-prod"
    }
    "app-prod-web-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "app-prod-web-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/354a71d2-11ed-4c91-abb2-a08a2b4abe69/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "app-prod-web-tf-contributor-appproddiag" = {
      service_principal_reference = "app-prod-web-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/f4722c2d-47d5-4513-a562-80465e3ee813/resourceGroups/rg-app-prod-diag-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappproddiagweu1002"
    }
    "app-prod-web-tf-reader-mgmtshrdimg" = {
      service_principal_reference = "app-prod-web-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/3bdf403f-77ac-4879-8fba-fa41c2cc94ee/resourceGroups/rg-mgmt-shrd-vmimg-weu1-001"
    }
    "app-prod-web-tf-kvadmin-appprodkv" = {
      service_principal_reference = "app-prod-web-tf"
      role_definition_name        = "Key Vault Administrator"
      scope                       = "/subscriptions/f4722c2d-47d5-4513-a562-80465e3ee813/resourceGroups/rg-app-prod-kv-weu1-001/providers/Microsoft.KeyVault/vaults/kv-app-prod-kv-weu1-001"
    }
    "app-prod-web-tf-reader-appdevlb" = {
      service_principal_reference = "app-prod-web-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/f4722c2d-47d5-4513-a562-80465e3ee813/resourceGroups/rg-app-prod-lb-weu1-001"
    }
    "app-prod-sql-tf-contributor-appprodsql" = {
      service_principal_reference = "app-prod-sql-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/f4722c2d-47d5-4513-a562-80465e3ee813/resourceGroups/rg-app-prod-sql-weu1-001"
    }
    "app-prod-sql-tf-blobcontributor-appprodcontainer" = {
      service_principal_reference = "app-prod-sql-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/f4722c2d-47d5-4513-a562-80465e3ee813/resourceGroups/rg-app-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappprodtfweu1001/blobServices/default/containers/app-prod"
    }
    "app-prod-sql-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "app-prod-sql-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/354a71d2-11ed-4c91-abb2-a08a2b4abe69/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "app-prod-sql-tf-contributor-appproddiag" = {
      service_principal_reference = "app-prod-sql-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/f4722c2d-47d5-4513-a562-80465e3ee813/resourceGroups/rg-app-prod-diag-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappproddiagweu1002"
    }
    "app-prod-sql-tf-reader-mgmtshrdimg" = {
      service_principal_reference = "app-prod-sql-tf"
      role_definition_name        = "Reader"
      scope                       = "/subscriptions/3bdf403f-77ac-4879-8fba-fa41c2cc94ee/resourceGroups/rg-mgmt-shrd-vmimg-weu1-001"
    }
    "app-prod-sql-tf-kvadmin-appprodkv" = {
      service_principal_reference = "app-prod-sql-tf"
      role_definition_name        = "Key Vault Administrator"
      scope                       = "/subscriptions/f4722c2d-47d5-4513-a562-80465e3ee813/resourceGroups/rg-app-prod-kv-weu1-001/providers/Microsoft.KeyVault/vaults/kv-app-prod-kv-weu1-001"
    }
    "app-prod-kv-tf-contributor-appprodkv" = {
      service_principal_reference = "app-prod-kv-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/f4722c2d-47d5-4513-a562-80465e3ee813/resourceGroups/rg-app-prod-kv-weu1-001"
    }
    "app-prod-kv-tf-blobcontributor-appprodcontainer" = {
      service_principal_reference = "app-prod-kv-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/f4722c2d-47d5-4513-a562-80465e3ee813/resourceGroups/rg-app-prod-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtappprodtfweu1001/blobServices/default/containers/app-prod-kv"
    }
    "app-prod-kv-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "app-prod-kv-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/354a71d2-11ed-4c91-abb2-a08a2b4abe69/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
    "mgmt-shrd-vmimg-tf-contributor-mgmtshrdvmimg" = {
      service_principal_reference = "mgmt-shrd-vmimg-tf"
      role_definition_name        = "Contributor"
      scope                       = "/subscriptions/3bdf403f-77ac-4879-8fba-fa41c2cc94ee/resourceGroups/rg-mgmt-shrd-vmimg-weu1-001"
    }
    "mgmt-shrd-vmimg-tf-blobcontributor-mgmtshrdcontainer" = {
      service_principal_reference = "mgmt-shrd-vmimg-tf"
      role_definition_name        = "Storage Blob Data Contributor"
      scope                       = "/subscriptions/3bdf403f-77ac-4879-8fba-fa41c2cc94ee/resourceGroups/rg-mgmt-shrd-tf-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtshrdtfweu1001/blobServices/default/containers/mgmt-shrd"
    }
    "mgmt-shrd-vmimg-tf-moncontributor-mgmtprodlogs" = {
      service_principal_reference = "mgmt-shrd-vmimg-tf"
      role_definition_name        = "Monitoring Contributor"
      scope                       = "/subscriptions/354a71d2-11ed-4c91-abb2-a08a2b4abe69/resourceGroups/rg-mgmt-prod-log-weu1-001/providers/Microsoft.OperationalInsights/workspaces/log-mgmt-prod-log-weu1-001"
    }
  }
  rbac_role_assignments_objects = {
    "galmgmtshrdvmimgweu1001-blobreader-mgmtshrdscriptscontainer" = {
      object_reference     = "galmgmtshrdvmimgweu1001"
      role_definition_name = "Storage Blob Data Reader"
      scope                = "/subscriptions/3bdf403f-77ac-4879-8fba-fa41c2cc94ee/resourceGroups/rg-mgmt-shrd-vmimg-weu1-001/providers/Microsoft.Storage/storageAccounts/stjtmgmtshrdvmimgweu1001/blobServices/default/containers/scripts"
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
      name              = "Virtual Network Peerer (Custom)"
      scope             = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      description       = "Create and delete Azure VNet peerings"
      actions           = ["Microsoft.Network/virtualNetworks/*/read", "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/*", "Microsoft.Network/virtualNetworks/read", "Microsoft.Network/virtualNetworks/peer/*"]
      assignable_scopes = ["/providers/Microsoft.Management/managementGroups/jamietaffurelli"]
    },
    {
      name              = "Load Balancer Backend Address Pool Joiner (Custom)"
      scope             = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      description       = "Attach resources to backend address pool of a load balancer"
      actions           = ["Microsoft.Network/loadBalancers/backendAddressPools/join/action"]
      assignable_scopes = ["/providers/Microsoft.Management/managementGroups/jamietaffurelli"]
    },
    {
      name              = "Private Link Joiner (Custom)"
      scope             = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      description       = "Attach resources to private links"
      actions           = ["Microsoft.Network/privateLinkServices/read", "Microsoft.Network/privateLinkServices/privateEndpointConnections/read"]
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
    },
    {
      name              = "SQL VM Register (Custom)"
      scope             = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      description       = "Register the Microsoft.SqlVirtualMachine provider to a subscription"
      actions           = ["Microsoft.SqlVirtualMachine/register/action"]
      assignable_scopes = ["/providers/Microsoft.Management/managementGroups/jamietaffurelli"]
    }
  ]
  custom_rbac_role_assignments_service_principals = {
    "setup-landing-zones-tf-lockcont-org" = {
      service_principal_reference = "setup-landing-zones-tf"
      custom_role_reference       = "Lock Contributor (Custom)"
      scope                       = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
    }
    "conn-dev-hub-tf-vnetpeer-appdevnet" = {
      service_principal_reference = "conn-dev-hub-tf"
      custom_role_reference       = "Virtual Network Peerer (Custom)"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-net-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-app-dev-net-weu1-001"
    }
    "conn-dev-bas-tf-prefixjoin-conndevhubprefix" = {
      service_principal_reference = "conn-dev-bas-tf"
      custom_role_reference       = "Public IP Prefix Joiner (Custom)"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-hub-weu1-001/providers/Microsoft.Network/publicIPPrefixes/ippre-conn-dev-hub-weu1-001"
    }
    "conn-dev-bas-tf-subnetjoin-conndevhubsubnet" = {
      service_principal_reference = "conn-dev-bas-tf"
      custom_role_reference       = "Subnet Joiner (Custom)"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-hub-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-conn-dev-hub-weu1-001/subnets/AzureBastionSubnet"
    }
    "conn-dev-afw-tf-prefixjoin-conndevhubprefix" = {
      service_principal_reference = "conn-dev-afw-tf"
      custom_role_reference       = "Public IP Prefix Joiner (Custom)"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-hub-weu1-001/providers/Microsoft.Network/publicIPPrefixes/ippre-conn-dev-hub-weu1-001"
    }
    "conn-dev-afw-tf-subnetjoin-conndevhubsubnet" = {
      service_principal_reference = "conn-dev-afw-tf"
      custom_role_reference       = "Subnet Joiner (Custom)"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-hub-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-conn-dev-hub-weu1-001/subnets/AzureFirewallSubnet"
    }
    "conn-dev-afw-tf-fwpoljoin-conndevfwpol" = {
      service_principal_reference = "conn-dev-afw-tf"
      custom_role_reference       = "Firewall Policy Joiner (Custom)"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-afwp-weu1-001/providers/Microsoft.Network/firewallPolicies/afwp-conn-dev-afwp-weu1-001"
    }
    "conn-dev-afw-tf-fwcont-conndevhub" = {
      service_principal_reference = "conn-dev-afw-tf"
      custom_role_reference       = "Firewall Contributor (Custom)"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-hub-weu1-001"
    }
    "conn-dev-afd-tf-fwcont-conndevhub" = {
      service_principal_reference = "conn-dev-afd-tf"
      custom_role_reference       = "Private Link Joiner (Custom)"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-lb-weu1-001/providers/Microsoft.Network/privateLinkServices/web"
    }
    "conn-prod-hub-tf-vnetpeer-appprodnet" = {
      service_principal_reference = "conn-prod-hub-tf"
      custom_role_reference       = "Virtual Network Peerer (Custom)"
      scope                       = "/subscriptions/f4722c2d-47d5-4513-a562-80465e3ee813/resourceGroups/rg-app-prod-net-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-app-prod-net-weu1-001"
    }
    "conn-prod-bas-tf-prefixjoin-connprodhubprefix" = {
      service_principal_reference = "conn-prod-bas-tf"
      custom_role_reference       = "Public IP Prefix Joiner (Custom)"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-hub-weu1-001/providers/Microsoft.Network/publicIPPrefixes/ippre-conn-prod-hub-weu1-001"
    }
    "conn-prod-bas-tf-subnetjoin-connprodhubsubnet" = {
      service_principal_reference = "conn-prod-bas-tf"
      custom_role_reference       = "Subnet Joiner (Custom)"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-hub-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-conn-prod-hub-weu1-001/subnets/AzureFirewallSubnet"
    }
    "conn-prod-afw-tf-prefixjoin-connprodhubprefix" = {
      service_principal_reference = "conn-prod-afw-tf"
      custom_role_reference       = "Public IP Prefix Joiner (Custom)"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-hub-weu1-001/providers/Microsoft.Network/publicIPPrefixes/ippre-conn-prod-hub-weu1-001"
    }
    "conn-prod-afw-tf-subnetjoin-connprodhubsubnet" = {
      service_principal_reference = "conn-prod-afw-tf"
      custom_role_reference       = "Subnet Joiner (Custom)"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-hub-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-conn-prod-hub-weu1-001/subnets/AzureBastionSubnet"
    }
    "conn-prod-afw-tf-fwpoljoin-connprodfwpol" = {
      service_principal_reference = "conn-prod-afw-tf"
      custom_role_reference       = "Firewall Policy Joiner (Custom)"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-afwp-weu1-001/providers/Microsoft.Network/firewallPolicies/afwp-conn-prod-afwp-weu1-001"
    }
    "conn-prod-afw-tf-fwcont-connprodhub" = {
      service_principal_reference = "conn-prod-afw-tf"
      custom_role_reference       = "Firewall Contributor (Custom)"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-hub-weu1-001"
    }
    "conn-prod-afd-tf-fwcont-conndevhub" = {
      service_principal_reference = "conn-prod-afd-tf"
      custom_role_reference       = "Private Link Joiner (Custom)"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-app-prod-lb-weu1-001/providers/Microsoft.Network/privateLinkServices/web"
    }
    "app-dev-net-tf-vnetpeer-appdevnet" = {
      service_principal_reference = "app-dev-net-tf"
      custom_role_reference       = "Virtual Network Peerer (Custom)"
      scope                       = "/subscriptions/3d6c3571-dbcd-47fa-a4f1-f2993adb6c90/resourceGroups/rg-conn-dev-hub-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-conn-dev-hub-weu1-001"
    }
    "app-dev-lb-tf-subnetjoin-appdevnet" = {
      service_principal_reference = "app-dev-lb-tf"
      custom_role_reference       = "Subnet Joiner (Custom)"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-net-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-app-dev-net-weu1-001"
    }
    "app-dev-web-tf-subnetjoin-appdevnet" = {
      service_principal_reference = "app-dev-web-tf"
      custom_role_reference       = "Subnet Joiner (Custom)"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-net-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-app-dev-net-weu1-001/subnets/snet-web"
    }
    "app-dev-web-tf-lbjoin-appdevlb" = {
      service_principal_reference = "app-dev-web-tf"
      custom_role_reference       = "Load Balancer Backend Address Pool Joiner (Custom)"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-lb-weu1-001/providers/Microsoft.Network/loadBalancers/lbi-app-dev-lb-weu1-001/backendAddressPools/web-backend-pool"
    }
    "app-dev-sql-tf-subnetjoin-appdevnet" = {
      service_principal_reference = "app-dev-sql-tf"
      custom_role_reference       = "Subnet Joiner (Custom)"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-net-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-app-dev-net-weu1-001/subnets/snet-sql"
    }
    "app-dev-sql-tf-sqlreg-appdev" = {
      service_principal_reference = "app-dev-sql-tf"
      custom_role_reference       = "SQL VM Register (Custom)"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241"
    }
    "app-dev-redis-tf-subnetjoin-appdevnet" = {
      service_principal_reference = "app-dev-redis-tf"
      custom_role_reference       = "Subnet Joiner (Custom)"
      scope                       = "/subscriptions/5284e392-c44d-444a-bf2e-07452a860241/resourceGroups/rg-app-dev-net-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-app-dev-net-weu1-001/subnets/snet-redis"
    }
    "app-prod-net-tf-vnetpeer-appprodnet" = {
      service_principal_reference = "app-prod-net-tf"
      custom_role_reference       = "Virtual Network Peerer (Custom)"
      scope                       = "/subscriptions/5091f2ec-a527-4b51-8e63-9f5de65e3a66/resourceGroups/rg-conn-prod-hub-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-conn-prod-hub-weu1-001"
    }
    "app-prod-lb-tf-subnetjoin-appprodnet" = {
      service_principal_reference = "app-prod-lb-tf"
      custom_role_reference       = "Subnet Joiner (Custom)"
      scope                       = "/subscriptions/f4722c2d-47d5-4513-a562-80465e3ee813/resourceGroups/rg-app-prod-net-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-app-prod-net-weu1-001"
    }
    "app-prod-web-tf-subnetjoin-appprodnet" = {
      service_principal_reference = "app-prod-web-tf"
      custom_role_reference       = "Subnet Joiner (Custom)"
      scope                       = "/subscriptions/f4722c2d-47d5-4513-a562-80465e3ee813/resourceGroups/rg-app-prod-net-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-app-prod-net-weu1-001/subnets/snet-web"
    }
    "app-prod-web-tf-lbjoin-appprodlb" = {
      service_principal_reference = "app-prod-web-tf"
      custom_role_reference       = "Load Balancer Backend Address Pool Joiner (Custom)"
      scope                       = "/subscriptions/f4722c2d-47d5-4513-a562-80465e3ee813/resourceGroups/rg-app-prod-lb-weu1-001/providers/Microsoft.Network/loadBalancers/lbi-app-prod-lb-weu1-001/backendAddressPools/web-backend-pool"
    }
    "app-prod-sql-tf-subnetjoin-appprodnet" = {
      service_principal_reference = "app-prod-sql-tf"
      custom_role_reference       = "Subnet Joiner (Custom)"
      scope                       = "/subscriptions/f4722c2d-47d5-4513-a562-80465e3ee813/resourceGroups/rg-app-prod-net-weu1-001/providers/Microsoft.Network/virtualNetworks/vnet-app-prod-net-weu1-001/subnets/snet-sql"
    }
    "app-prod-sql-tf-sqlreg-appprod" = {
      service_principal_reference = "app-prod-sql-tf"
      custom_role_reference       = "SQL VM Register (Custom)"
      scope                       = "/subscriptions/f4722c2d-47d5-4513-a562-80465e3ee813"
    }
  }
  custom_rbac_role_assignments_objects = {
    "galmgmtshrdvmimgweu1001-imgbuilder" = {
      object_reference      = "galmgmtshrdvmimgweu1001"
      custom_role_reference = "Image Creator (Custom)"
      scope                 = "/subscriptions/3bdf403f-77ac-4879-8fba-fa41c2cc94ee/resourceGroups/rg-mgmt-shrd-vmimg-weu1-001/providers/Microsoft.Compute/galleries/galmgmtshrdvmimgweu1001"
    }
  }
  log_analytics_workspace = {
    name                = "log-mgmt-prod-log-weu1-001"
    resource_group_name = "rg-mgmt-prod-log-weu1-001"
  }
}
