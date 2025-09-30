
module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.24"

  suffix = [local.env_short]
}

module "kv" {
  source  = "cloudnationhq/kv/azure"
  version = "~> 4.0"

  naming = local.naming 
  tags   = var.default_tags
  vault = {
    name                = "kv-${local.env_short}-app-${var.app_name}-${random_integer.ooo.result}"
    location            = data.azurerm_virtual_network.vnet.location
    resource_group_name = data.azurerm_virtual_network.vnet.resource_group_name
    }
}