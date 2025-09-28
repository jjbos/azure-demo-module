variable "vm_size_app" {
  description = "Define the VM size to use"
  type        = string
  default     = "Standard_B2ms"
}

variable "count_vm_instances" {
  description = "Set the number of VM instances to create"
  type        = number
  default     = 1
}

variable "app_name" {
  description = "Set the application name"
  type        = string
}

variable "environment" {
  description = "Define which environment to use"
  type        = string
}

variable "external_ip" {
  description = "Set your external IP, use default 0.0.0.0/0 for access from everywhere"
  type        = string
  default     = "0.0.0.0/0"
}

variable "override_cluster_resources" {
  description = "Defines if cluster resources should be created"
  type        = bool
  default     = false
}