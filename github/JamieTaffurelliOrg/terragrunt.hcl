terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/github-tf///?ref=0.1.3"
}

remote_state {

  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    resource_group_name  = "rg-tfext-prod-tf-frc1-001"
    storage_account_name = "stjttfextpprodtffrc1001"
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
    }
  ]
}
