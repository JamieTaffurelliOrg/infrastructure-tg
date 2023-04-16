remote_state {

  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket         = "test123backups"
    key            = "oidc/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}

terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/aws-oidc-tf///?ref=0.0.5"
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "aws" {
  region = "us-east-1"
}
EOF

}

locals {
  tags = {
    data-classification = "confidential"
    criticality         = "mission-critical"
    ops-commitment      = "workload-operations"
    ops-team            = "sre"
    cost-owner          = "jltaffurelli@outlook.com"
    owner               = "jltaffurelli@outlook.com"
    sla                 = "high"
    environment         = "prod"
    stack               = "connectivity"
  }
}

inputs = {

  oidc_provider_url = "https://token.actions.githubusercontent.com"
  oidc_client_ids   = ["https://github.com/JamieTaffurelliOrg", "sts.amazonaws.com"]
  thumbprint_urls   = ["https://token.actions.githubusercontent.com/.well-known/openid-configuration"]
  policy_documents = {
    "infrastructure-tg-aws-master-oidc-env" = {
      conditions = {
        "infrastructure-tg-aws-master-oidc-env" = {
          test     = "StringEquals"
          values   = ["repo:JamieTaffurelliOrg/infrastructure-tg:environment:aws.master.oidc.deploy"]
          variable = "token.actions.githubusercontent.com:sub"
        }
        "sts-aws" = {
          test     = "StringEquals"
          values   = ["sts.amazonaws.com"]
          variable = "token.actions.githubusercontent.com:aud"
        }
      }
    }
  }
  roles = [
    {
      name                      = "master-admin"
      description               = "master-admin"
      policy_document_reference = "infrastructure-tg-aws-master-oidc-env"
      path                      = "/"
      permissions_boundary      = ""
      policy_arns               = ["arn:aws:iam::aws:policy/AdministratorAccess"]
    }
  ]
}
