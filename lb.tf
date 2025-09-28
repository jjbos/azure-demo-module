module "lb_app" {
  count               = local.cluster_resources ? 1 : 0
  source              = "git@github.com:terraform-azurerm-modules/lb-module.git?ref=1.0.0"
  env_short           = local.env_short
  app_name            = var.app_name
  subnet_id           = data.azurerm_subnet.private_subnet.id
  protocol_map        = local.protocol_map
  resource_group_name = data.azurerm_virtual_network.vnet.resource_group_name
  location            = data.azurerm_virtual_network.vnet.location
  vmss_name           = module.vmss_app.name
}