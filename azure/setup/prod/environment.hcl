locals {
  environment_name = "prod"
  default_tags = {
    environment = local.environment_name
  }
}
