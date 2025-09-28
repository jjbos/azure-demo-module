data "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.environment}"
  resource_group_name = "rg-${var.environment}"
}

data "azurerm_subnet" "private_subnet" {
  name                 = "subnet-${var.environment}-private"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
}

data "azurerm_subnet" "public_subnet" {
  name                 = "subnet-${var.environment}-public"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
}