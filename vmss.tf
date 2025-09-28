module "vmss_app" {
  source              = "git@github.com:terraform-azurerm-modules/vmss-module.git?ref=1.0.0" # example custom module
  name                = format("vmss-%s-app-%s", local.env_short, var.app_name)
  resource_group_name = data.azurerm_virtual_network.vnet.resource_group_name
  location            = data.azurerm_virtual_network.vnet.location
  vm_size             = var.vm_size_app
  instances           = var.count_vm_instances
  subnet_id           = data.azurerm_subnet.private_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg_app.id
  # Add disk size, image reference, etc. as needed for your module
}