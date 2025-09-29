module "vmss_app" {
  source              = "git@github.com:cloudnationhq/terraform-azure-vmss.git?ref=v2.1.1" # example custom module
  #name                = format("vmss-%s-app-%s", local.env_short, var.app_name)
  #resource_group_name = data.azurerm_virtual_network.vt.resource_group_name
  #location            = data.azurerm_virtual_network.vnet.location
  keyvault            = module.kv.vault.id
  naming              = local.naming
  depends_on          = [module.kv]

  vmss = {
    name                = format("vmss-%s-app-%s", local.env_short, var.app_name)
    location            = data.azurerm_virtual_network.vnet.location
    resource_group_name = data.azurerm_virtual_network.vnet.resource_group_name
    type                = "linux"

    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
    }
    generate_ssh_key = {
      enable = true
    }
    autoscaling = {
      min = var.vmss_app_min_size
      max = var.vmss_app_max_size
      rules = {
        increase = {
          metric_name      = "Percentage CPU"
          time_grain       = "PT1M"
          statistic        = "Average"
          time_window      = "PT5M"
          time_aggregation = "Average"
          operator         = "GreaterThan"
          threshold        = 80
          direction        = "Increase"
          value            = 1
          cooldown         = "PT1M"
          type             = "ChangeCount"
        }
        decrease = {
          metric_name      = "Percentage CPU"
          time_grain       = "PT1M"
          statistic        = "Average"
          time_window      = "PT5M"
          time_aggregation = "Average"
          operator         = "LessThan"
          threshold        = 20
          direction        = "Decrease"
          value            = 1
          cooldown         = "PT1M"
          type             = "ChangeCount"
        }
      }
    }
    interfaces = {
      internal = {
        subnet  = azurerm_subnet.demo_app_subnet.id
        primary = true
      }
    }
  }
}

    # instances           = var.count_vm_instances
  # subnet_id           = data.azurerm_subnet.private_subnet.id
  # network_security_group_id = azurerm_network_security_group.nsg_app.id
  # Add disk size, image reference, etc. as needed for your module