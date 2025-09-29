module "lb_app" {
  count               = local.cluster_resources ? 1 : 0
  source              = "git@github.com:azure/terraform-azurerm-loadbalancer.git?ref=4.4.0"
  type                = "private"
  frontend_subnet_id  = azurerm_subnet.demo_app_subnet.id
  lb_sku              = "Standard"
  frontend_private_ip_address_allocation = "Dynamic"
  resource_group_name = data.azurerm_virtual_network.vnet.resource_group_name
  lb_port = {
    http  = ["80", "Tcp", "80"]
    https = ["443", "Tcp", "443"]
  }

  lb_probe = {
    http  = ["Tcp", "80", ""]
    http2 = ["Http", "1443", "/"]
  }
}