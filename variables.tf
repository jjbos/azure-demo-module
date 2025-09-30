

variable "app_name" {
  description = "Set the application name"
  type        = string
}

variable "app_subnet" {
  description = "Set the application subnet"
  type        = string
}

variable "environment" {
  description = "Define which environment to use"
  type        = string
}

variable "default_tags" {
  description = "Default tags to be applied to all resources"
  type        = map(string)
  default     = {}
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

variable "vmss_min_size" {
  description = "Set the minimum number of app instances to create in autoscaling group"
  type        = number
  default     = 1
}

variable "vmss_max_size" {
  description = "Set the maximum number of app instances to create in autoscaling group"
  type        = number
  default     = 1
}

variable "vmss_image_publisher" {
  description = "Image publisher"
  type        = string
  default     = "Canonical"
}

variable "vmss_image_type" {
  description = "Image type"
  type        = string
  default     = "0001-com-ubuntu-server-jammy"
}

variable "vmss_image_sku" {
  description = "Image SKU"
  type        = string
  default     = "22_04-lts"
}

variable "vm_type_app" {
  type        = string
  default     = null
  description = "Define the instance type to use"
}

variable "vmss_size" {
  description = "Define the VM size to use"
  type        = string
  default     = "Standard_B2ms"
}

variable "vmss_image_version" {
  description = "Image version"
  type        = string
  default     = "latest"
}

variable "vmss_autoscale_increase_threshold" {
  description = "Autoscale increase threshold"
  type        = number
  default     = 80
}

variable "vmss_autoscale_decrease_threshold" {
  description = "Autoscale decrease threshold"
  type        = number
  default     = 20
}
