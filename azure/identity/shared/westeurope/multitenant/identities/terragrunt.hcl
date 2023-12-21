terraform {
  source = "git::https://github.com/JamieTaffurelliOrg/az-identity-tf///?ref=0.1.35"
}

include "azure" {
  path   = find_in_parent_folders("azure.hcl")
  expose = true
}

include "landing_zone" {
  path   = find_in_parent_folders("landing_zone.hcl")
  expose = true
}

include "environment" {
  path   = find_in_parent_folders("environment.hcl")
  expose = true
}

include "region" {
  path   = find_in_parent_folders("region.hcl")
  expose = true
}

include "tenant" {
  path   = find_in_parent_folders("tenant.hcl")
  expose = true
}

generate "provider" {

  path = "providers.tf"

  if_exists = "overwrite"

  contents = <<EOF
provider "azuread" {
}

provider "azurerm" {
  subscription_id = "${include.azure.locals.iden_shrd_subscription_id}"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias = "logs"
  subscription_id = "${include.azure.locals.mgmt_prod_subscription_id}"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
EOF

}

locals {
  org_prefix     = include.azure.locals.org_prefix
  location_full  = include.region.locals.region_full
  location_short = include.region.locals.region_short
}

inputs = {
  users = {
    "break-glass-1" = {
      user_principal_name = "alphabravo@jamietaffurelli.com"
      display_name        = "Alpha Bravo"
    }
    "break-glass-2" = {
      user_principal_name = "charliedelta@jamietaffurelli.com"
      display_name        = "Charlie Delta"
    }
  }
  objects = {
    "jamie-taffurelli-o365admin" = {
      object_id = "ba9d03b6-d18a-45cd-9095-d1aa741c2030"
    }
  }
  groups = {
    "${local.org_prefix}-owners-pim" = {
      display_name = "${local.org_prefix}-owners-pim"
      description  = "Azure AD Management Group Owners (PIM assignable)"
    }
    "${local.org_prefix}-globaladmins-pim" = {
      display_name = "${local.org_prefix}-globaladmins-pim"
      description  = "Azure AD Global Admins (PIM assignable)"
    }
    "${local.org_prefix}-contributors-pim" = {
      display_name = "${local.org_prefix}-contributors-pim"
      description  = "Azure AD Management Group Contributors (PIM assignable)"
    }
    "${local.org_prefix}-useraccessadmins-pim" = {
      display_name = "${local.org_prefix}-useraccessadmins-pim"
      description  = "Azure AD Management Group User Access Adminstrators (PIM assignable)"
    }
    "${local.org_prefix}-storageblobdatacontributors-pim" = {
      display_name = "${local.org_prefix}-storageblobdatacontributors-pim"
      description  = "Azure AD Management Group Storage Blob Data Contributors (PIM assignable)"
    }
    "${local.org_prefix}-keyvaultadmins-pim" = {
      display_name = "${local.org_prefix}-keyvaultadmin-pim"
      description  = "Azure AD Management Group Key Vault Adminstrators (PIM assignable)"
    }
    "${local.org_prefix}-vmloginadmins-pim" = {
      display_name = "${local.org_prefix}-vmloginadmins-pim"
      description  = "Azure AD Management Group VM Adminstrator Logins (PIM assignable)"
    }
    "${local.org_prefix}-awsorgadmins-pim" = {
      display_name = "${local.org_prefix}-awsorgadmins-pim"
      description  = "AWS Org Admins (PIM)"
    }
  }
  group_memberships_objects = {
    "jamie-taffurelli-o365admin-${local.org_prefix}-owners-pim" = {
      group_reference  = "${local.org_prefix}-owners-pim"
      member_reference = "jamie-taffurelli-o365admin"
    }
    "jamie-taffurelli-o365admin-${local.org_prefix}-globaladmins-pim" = {
      group_reference  = "${local.org_prefix}-globaladmins-pim"
      member_reference = "jamie-taffurelli-o365admin"
    }
    "jamie-taffurelli-o365admin-${local.org_prefix}-contributors-pim" = {
      group_reference  = "${local.org_prefix}-contributors-pim"
      member_reference = "jamie-taffurelli-o365admin"
    }
    "jamie-taffurelli-o365admin-${local.org_prefix}-useraccessadmins-pim" = {
      group_reference  = "${local.org_prefix}-useraccessadmins-pim"
      member_reference = "jamie-taffurelli-o365admin"
    }
    "jamie-taffurelli-o365admin-${local.org_prefix}-storageblobdatacontributors-pim" = {
      group_reference  = "${local.org_prefix}-storageblobdatacontributors-pim"
      member_reference = "jamie-taffurelli-o365admin"
    }
    "jamie-taffurelli-o365admin-${local.org_prefix}-keyvaultadmins-pim" = {
      group_reference  = "${local.org_prefix}-keyvaultadmins-pim"
      member_reference = "jamie-taffurelli-o365admin"
    }
    "jamie-taffurelli-o365admin-${local.org_prefix}-vmloginadmins-pim" = {
      group_reference  = "${local.org_prefix}-vmloginadmins-pim"
      member_reference = "jamie-taffurelli-o365admin"
    }
  }
  role_assignments_users = {
    "break-glass-1-global-admin" = {
      user_reference = "break-glass-1"
      template_id    = "62e90394-69f5-4237-9190-012177145e10"
    }
    "break-glass-2-global-admin" = {
      user_reference = "break-glass-2"
      template_id    = "62e90394-69f5-4237-9190-012177145e10"
    }
  }
  rbac_role_definitions = [
    {
      name              = "Lock Contributor (Custom)"
      scope             = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      description       = "Create, edit or delete resource locks"
      actions           = ["Microsoft.Authorization/locks/*"]
      assignable_scopes = ["/providers/Microsoft.Management/managementGroups/jamietaffurelli"]
    },
    {
      name              = "Public IP Prefix Joiner (Custom)"
      scope             = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      description       = "Attach public IP addresses to public IP prefixes"
      actions           = ["Microsoft.Network/publicIPPrefixes/join/action", "Microsoft.Network/publicIPPrefixes/read"]
      assignable_scopes = ["/providers/Microsoft.Management/managementGroups/jamietaffurelli"]
    },
    {
      name              = "Subnet Joiner (Custom)"
      scope             = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      description       = "Attach resources to subnets"
      actions           = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/joinLoadBalancer/action", "Microsoft.Network/virtualNetworks/subnets/joinViaServiceEndpoint/action", "Microsoft.Network/virtualNetworks/subnets/joinLoadBalancer/action", "Microsoft.Network/virtualNetworks/*/read"]
      assignable_scopes = ["/providers/Microsoft.Management/managementGroups/jamietaffurelli"]
    },
    {
      name              = "Firewall Policy Joiner (Custom)"
      scope             = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      description       = "Attach firewalls to firewall policies"
      actions           = ["Microsoft.Network/firewallPolicies/join/action", "Microsoft.Network/firewallPolicies/read"]
      assignable_scopes = ["/providers/Microsoft.Management/managementGroups/jamietaffurelli"]
    },
    {
      name              = "Firewall Contributor (Custom)"
      scope             = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      description       = "Create and delete Azure Firewalls"
      actions           = ["Microsoft.Network/azureFirewalls/*", "Microsoft.Network/publicIPAddresses/*", "Microsoft.Insights/diagnosticSettings/*"]
      assignable_scopes = ["/providers/Microsoft.Management/managementGroups/jamietaffurelli"]
    },
    {
      name              = "Virtual Network Peerer (Custom)"
      scope             = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      description       = "Create and delete Azure VNet peerings"
      actions           = ["Microsoft.Network/virtualNetworks/*/read", "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/*", "Microsoft.Network/virtualNetworks/read", "Microsoft.Network/virtualNetworks/peer/*"]
      assignable_scopes = ["/providers/Microsoft.Management/managementGroups/jamietaffurelli"]
    },
    {
      name              = "Load Balancer Backend Address Pool Joiner (Custom)"
      scope             = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      description       = "Attach resources to backend address pool of a load balancer"
      actions           = ["Microsoft.Network/loadBalancers/backendAddressPools/join/action", "Microsoft.Network/loadBalancers/read"]
      assignable_scopes = ["/providers/Microsoft.Management/managementGroups/jamietaffurelli"]
    },
    {
      name              = "Private Link Joiner (Custom)"
      scope             = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      description       = "Attach resources to private links"
      actions           = ["Microsoft.Network/privateLinkServices/read", "Microsoft.Network/privateLinkServices/privateEndpointConnections/read"]
      assignable_scopes = ["/providers/Microsoft.Management/managementGroups/jamietaffurelli"]
    },
    {
      name        = "Image Creator (Custom)"
      scope       = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      description = "Create and delete Azure Compute Gallery images"
      actions = [
        "Microsoft.Compute/galleries/read",
        "Microsoft.Compute/galleries/images/read",
        "Microsoft.Compute/galleries/images/versions/read",
        "Microsoft.Compute/galleries/images/versions/write",
        "Microsoft.Compute/images/write",
        "Microsoft.Compute/images/read",
        "Microsoft.Compute/images/delete"
      ]
      assignable_scopes = ["/providers/Microsoft.Management/managementGroups/jamietaffurelli"]
    },
    {
      name        = "Service Fabric Mesh Register (Custom)"
      scope       = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      description = "Register the Microsoft.ServiceFabricMesh provider to a subscription"
      actions = [
        "Microsoft.ServiceFabricMesh/register/action"
      ]
      assignable_scopes = ["/providers/Microsoft.Management/managementGroups/jamietaffurelli"]
    },
    {
      name              = "SQL VM Register (Custom)"
      scope             = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      description       = "Register the Microsoft.SqlVirtualMachine provider to a subscription"
      actions           = ["Microsoft.SqlVirtualMachine/register/action"]
      assignable_scopes = ["/providers/Microsoft.Management/managementGroups/jamietaffurelli"]
    },
    {
      name              = "App Register (Custom)"
      scope             = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      description       = "Register the Microsoft.App provider to a subscription"
      actions           = ["Microsoft.App/register/action"]
      assignable_scopes = ["/providers/Microsoft.Management/managementGroups/jamietaffurelli"]
    },
    {
      name              = "Virtual WAN Joiner (Custom)"
      scope             = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      description       = "Join a virtual hub to a virtual WAN"
      actions           = ["Microsoft.Network/virtualWans/join/action", "Microsoft.Network/virtualWans/read"]
      assignable_scopes = ["/providers/Microsoft.Management/managementGroups/jamietaffurelli"]
    },
    {
      name              = "Virtual Hub Joiner (Custom)"
      scope             = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      description       = "Join a virtual hub to a virtual WAN"
      actions           = ["Microsoft.Network/virtualHubs/hubVirtualNetworkConnections/*", "Microsoft.Network/virtualHubs/read"]
      assignable_scopes = ["/providers/Microsoft.Management/managementGroups/jamietaffurelli"]
    }
  ]
  pim_assignments_groups = [
    {
      management_group_id = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      location            = local.location_full
      scope               = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      justification       = "Org Management Group Owner access"
      group_reference     = "${local.org_prefix}-owners-pim"
      role_definition_id  = "managementGroups/jamietaffurelli/providers/Microsoft.Authorization/roleDefinitions/8e3af657-a8ff-443c-a75c-2fe8c4bcb635"
      request_type        = "AdminUpdate"
      deploy              = false
    },
    {
      management_group_id = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      location            = local.location_full
      scope               = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      justification       = "Org Management Group Owner access"
      group_reference     = "${local.org_prefix}-contributors-pim"
      role_definition_id  = "managementGroups/jamietaffurelli/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"
      request_type        = "AdminUpdate"
      deploy              = false
    },
    {
      management_group_id = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      location            = local.location_full
      scope               = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      justification       = "Org Management Group Owner access"
      group_reference     = "${local.org_prefix}-useraccessadmins-pim"
      role_definition_id  = "managementGroups/jamietaffurelli/providers/Microsoft.Authorization/roleDefinitions/18d7d88d-d35e-4fb5-a5c3-7773c20a72d9"
      request_type        = "AdminUpdate"
      deploy              = false
    },
    {
      management_group_id = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      location            = local.location_full
      scope               = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      justification       = "Org Management Group Owner access"
      group_reference     = "${local.org_prefix}-storageblobdatacontributors-pim"
      role_definition_id  = "managementGroups/jamietaffurelli/providers/Microsoft.Authorization/roleDefinitions/ba92f5b4-2d11-453d-a403-e96b0029c9fe"
      request_type        = "AdminUpdate"
      deploy              = false
    },
    {
      management_group_id = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      location            = local.location_full
      scope               = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      justification       = "Org Management Group Owner access"
      group_reference     = "${local.org_prefix}-keyvaultadmins-pim"
      role_definition_id  = "managementGroups/jamietaffurelli/providers/Microsoft.Authorization/roleDefinitions/00482a5a-887f-4fb3-b363-3b7fe8e74483"
      request_type        = "AdminUpdate"
      deploy              = false
    },
    {
      management_group_id = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      location            = local.location_full
      scope               = "/providers/Microsoft.Management/managementGroups/jamietaffurelli"
      justification       = "Org Management Group Owner access"
      group_reference     = "${local.org_prefix}-vmloginadmins-pim"
      role_definition_id  = "managementGroups/jamietaffurelli/providers/Microsoft.Authorization/roleDefinitions/1c0163c0-47e6-4577-8991-ea5c82e286e4"
      request_type        = "AdminUpdate"
      deploy              = false
    }
  ]
  named_locations = [
    {
      name = "trusted-ips"
      ip_locations = {
        "trusted-ips" = {
          ip_ranges = ["0.0.0.0/0"]
          trusted   = true
        }
      }
    },
    {
      name = "trusted-locations"
      country_locations = {
        "trusted-locations" = {
          countries_and_regions                 = ["GB"]
          include_unknown_countries_and_regions = true
        }
      }
    }
  ]
  conditional_access_policies = [
    {
      name                = "mfa-all"
      sign_in_risk_levels = ["none"]
      applications = {
        included_applications = ["All"]
      }
      locations = {
        included_location_ids = ["All"]
      }
      platforms = {
        included_platforms = ["all"]
      }
      users = {
        included_user_ids        = ["All"]
        excluded_user_references = ["break-glass-1", "break-glass-2"]
      }
      grant_controls = {
        operator          = "AND"
        built_in_controls = ["mfa"]
      }
    }
  ]
  log_analytics_workspace = {
    name                = "log-mgmt-prod-log-${local.location_short}-001"
    resource_group_name = "rg-mgmt-prod-log-${local.location_short}-001"
  }
}
