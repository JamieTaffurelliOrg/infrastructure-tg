remote_state {

  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket         = "s3-jt-prod-tf-weu1-001"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "AFT-Management-setup-terraform-lock"
    encrypt        = true
  }
}
