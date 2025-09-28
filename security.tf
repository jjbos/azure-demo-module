resource "azurerm_network_security_group" "nsg_app" {
  name                = "nsg-${local.env_short}-app-${var.app_name}"
  location            = data.azurerm_virtual_network.vnet.location
  resource_group_name = data.azurerm_virtual_network.vnet.resource_group_name

  dynamic "security_rule" {
    for_each = local.ports_ingress_app
    content {
      name                       = "AllowAppPort${security_rule.value}"
      priority                   = 100 + security_rule.key * 10
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value
      source_address_prefix      = var.external_ip
      destination_address_prefix = "*"
    }
  }
}