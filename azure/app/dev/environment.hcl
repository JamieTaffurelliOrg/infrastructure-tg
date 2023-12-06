locals {
  environment_name = "dev"
  default_tags = {
    environment = local.environment_name
  }
}
