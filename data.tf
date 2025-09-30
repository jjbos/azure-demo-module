data "azurerm_virtual_network" "vnet" {
  name                = "vix${substr(var.environment, 0, 1)}01-mgmt-weu-ntwk-vnet"
  resource_group_name = "vix${substr(var.environment, 0, 1)}01-mgmt-weu-ntwk-rsg"
}

resource "random_integer" "ooo" {
  min = 0
  max = 999
}

output "random_number" {
  value = format("%03d", random_integer.ooo.result)
}