terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/github-tf///?ref=0.1.18"
}

remote_state {

  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    resource_group_name  = "rg-tfext-prod-tf-weu1-001"
    storage_account_name = "stjttfextprodtfweu1001"
    container_name       = "github"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    use_azuread_auth     = true
  }
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "github" {
    owner = "JamieTaffurelliOrg"
    read_delay_ms = 250
}
EOF

}

locals {
}

inputs = {

  default_repositories = [
    {
      name           = "infrastructure-tg"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "vm-config"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "aws-aft-customizations-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "aws-aft-requests-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "aws-aft-globalcustomizations-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "aws-aft-provisioning-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "devops-blog"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "github-actions-templates"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    }
  ]

  tf_repositories = [
    {
      name           = "github-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-landingzone-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-landingzone-storage-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-identity-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-logging-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-resourcegroup-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-hubvirtualnetwork-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-spokevirtualnetwork-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-privatedns-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-bastion-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-firewall-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-firewallmanager-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-frontdoor-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-frontdoorwaf-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-publicdns-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-loadbalancer-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-vmimagegallery-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-vmimagetemplate-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-keyvault-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-windowsvm-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-redis-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-acr-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-aci-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-appgw-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-ase-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-linuxwebapp-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-windowswebapp-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-virtualhub-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-staticwebapp-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-containerapp-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-virtualwan-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-mssql-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-managedmssql-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-containerappenv-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-dnsresolver-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-windowsvmscaleset-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-publicip-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-waf-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-cosmosdb-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-servicebus-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-storageaccount-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "az-datalake-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "aws-ipam-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "aws-oidc-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "aws-route53-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    },
    {
      name           = "aws-identity-tf"
      visibility     = "public"
      code_owners    = "@JamieTaffurelli"
      enforce_admins = false
    }
  ]
}
