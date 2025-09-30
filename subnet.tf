# Subnet for the app within the existing VNet (must not overlap with other subnets)
resource "azurerm_subnet" "demo_app_subnet" {
  name                 = format("subnet-%s-app-%s", local.env_short, var.app_name)
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  address_prefixes     = [var.app_subnet]
}

# Assign the NSG to the subnet
resource "azurerm_subnet_network_security_group_association" "demo_app_subnet_nsg" {
  subnet_id                 = azurerm_subnet.demo_app_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg_app.id
}