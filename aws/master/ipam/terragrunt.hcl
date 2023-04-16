remote_state {

  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket         = "test123backups"
    key            = "ipam/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}

terraform {
  source = "git::https://github.com/aws-ia/terraform-aws-ipam///?ref=1.2.1"
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

  top_cidr = ["172.16.0.0/12", "192.168.0.0/16"]
  top_name = "root"

  pool_configurations = {
    dev = {
      description = "DEV pool"
      cidr        = ["192.168.0.0/16"]

      sub_pools = {

        eu-west-1 = {
          name                     = "eu-west-1"
          locale                   = "eu-west-1"
          cidr                     = ["192.168.0.0/19"]
          ram_share_principals     = ""
          allocation_resource_tags = merge(local.tags, { workload-name = "ipam" })
        }
      }
    }
  }
}
