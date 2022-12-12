terraform {
  source = "../../../github-tf"
}

/*remote_state {

  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    resource_group_name  = "terraform"
    storage_account_name = "terraformstatedevsa"
    container_name       = "initial"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    use_azuread_auth     = true
  }
}*/

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
    }
  ]
}
