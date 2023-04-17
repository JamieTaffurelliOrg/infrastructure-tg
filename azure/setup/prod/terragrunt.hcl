remote_state {

  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    resource_group_name  = "rg-stp-prod-tf-weu1-001"
    storage_account_name = "stjtstpprodtfweu1001"
    container_name       = "setup-prod"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    use_azuread_auth     = true
  }
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
EOF

}
