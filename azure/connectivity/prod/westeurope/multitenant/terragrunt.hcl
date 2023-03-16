remote_state {

  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    resource_group_name  = "rg-conn-prod-tf-frc1-001"
    storage_account_name = "stjtconnprodtffrc1001"
    container_name       = "conn-prod"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    use_azuread_auth     = true
  }
}
