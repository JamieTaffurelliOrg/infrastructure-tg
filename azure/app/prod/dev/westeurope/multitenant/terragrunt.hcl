remote_state {

  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    resource_group_name  = "rg-app-prod-tf-weu1-001"
    storage_account_name = "stjtappprodtfweu1001"
    container_name       = "app-prod"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    use_azuread_auth     = true
  }
}
