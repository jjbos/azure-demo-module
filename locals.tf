locals {
  env_map = {
    "development" = "dev"
    "test"        = "test"
    "acceptance"  = "acc"
    "production"  = "prod"
  }
  env_short = lookup(local.env_map, var.environment, null)

  default_cluster = {
    "development" = false
    "test"        = false
    "acceptance"  = true
    "production"  = true
  }
  default_cluster_resources = lookup(local.default_cluster, var.environment, false)
  cluster_resources = local.default_cluster_resources || var.override_cluster_resources

  ports_ingress_app_map = {
    "crm"     = [443, 55123, 55234],
    "default" = [443, 55123]
  }
  ports_ingress_app = lookup(local.ports_ingress_app_map, var.app_name, local.ports_ingress_app_map["default"])
  protocol_map      = { for idx, val in local.ports_ingress_app : idx => val }
}

locals {
  naming = {
    # lookup outputs to have consistent naming
    for type in local.naming_types : type => lookup(module.naming, type).name
  }

  naming_types = ["subnet", "network_security_group", "key_vault_secret"]
}