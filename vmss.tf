module "vmss_app" {
  source   = "git@github.com:cloudnationhq/terraform-azure-vmss.git?ref=v2.1.1"
  keyvault = module.kv.vault.id
  naming   = local.naming
  tags     = var.default_tags
  depends_on = [module.kv]

  vmss = {
    name                = format("vmss-%s-app-%s", local.env_short, var.app_name)
    location            = data.azurerm_virtual_network.vnet.location
    resource_group_name = data.azurerm_virtual_network.vnet.resource_group_name
    type                = "linux"
    sku                 = var.vmss_size
    source_image_reference = {
      publisher = var.vmss_image_publisher
      offer     = var.vmss_image_type
      sku       = var.vmss_image_sku
      version   = var.vmss_image_version
    }
    generate_ssh_key = {
      enable = true
    }
    autoscaling = {
      name  = format("scaler-%s-app-%s", local.env_short, var.app_name)
      min   = var.vmss_min_size
      max   = var.vmss_max_size
      rules = {
        increase = {
          metric_name      = "Percentage CPU"
          time_grain       = "PT1M"
          statistic        = "Average"
          time_window      = "PT5M"
          time_aggregation = "Average"
          operator         = "GreaterThan"
          threshold        = var.vmss_autoscale_increase_threshold
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
          threshold        = var.vmss_autoscale_decrease_threshold
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
