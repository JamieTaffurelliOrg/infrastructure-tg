locals = {
  cloud        = read_terragrunt_config(find_in_parent_folders("azure.hcl"))
  landing_zone = read_terragrunt_config(find_in_parent_folders("landing_zone.hcl"))
  environment  = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  region       = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  tenant       = read_terragrunt_config(find_in_parent_folders("tenant.hcl"))
}
remote_state {

  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    resource_group_name  = "rg-app-dev-tf-weu1-001"
    storage_account_name = "stjtappdevtfweu1001"
    container_name       = "app-dev"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    use_azuread_auth     = true
  }
}
