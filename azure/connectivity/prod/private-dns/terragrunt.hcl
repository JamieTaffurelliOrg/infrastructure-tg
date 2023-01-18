terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-privatedns-tf///?ref=0.0.3"
}

include {
  path = find_in_parent_folders()
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azurerm" {
  subscription_id = "9689d784-a98b-49f0-8601-43a18ce83ab4"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
EOF

}

inputs = {

  resource_group_name = "rg-conn-prod-prvdns-weu1-001"
  private_dns_zones = [
    {
      name = "privatelink.azure-automation.net"
    },
    {
      name = "privatelink.database.windows.net"
    },
    {
      name = "privatelink.blob.core.windows.net"
    },
    {
      name = "privatelink.table.core.windows.net"
    },
    {
      name = "privatelink.queue.core.windows.net"
    },
    {
      name = "privatelink.file.core.windows.net"
    },
    {
      name = "privatelink.web.core.windows.net"
    },
    {
      name = "privatelink.batch.azure.com"
    },
    {
      name = "privatelink.vaultcore.azure.net"
    },
    {
      name = "internal.jamietaffurelli.com"
    }
  ]
}
