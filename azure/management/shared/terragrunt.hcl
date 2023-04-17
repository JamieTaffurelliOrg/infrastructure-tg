remote_state {

  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    resource_group_name  = "rg-mgmt-shrd-tf-weu1-001"
    storage_account_name = "stjtmgmtshrdtfweu1001"
    container_name       = "mgmt-shrd"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    use_azuread_auth     = true
  }
}
