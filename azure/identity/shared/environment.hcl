locals {
  environment = "shrd"
}

remote_state {

  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    resource_group_name  = "rg-iden-shrd-tf-weu1-001"
    storage_account_name = "stjtidenshrdtfweu1001"
    container_name       = "iden-shrd"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    use_azuread_auth     = true
  }
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azuread" {
}

provider "azurerm" {
  subscription_id = ${include.azure.locals.iden_shrd_subscription_id}

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
  ${include.azure.locals.mgmt_prod_subscription_id}

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
EOF

}
