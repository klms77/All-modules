#variable "vm_name" {}
variable "location" {}
variable "resource_group_name" {}
#variable "subnet_id" {}
variable "vm_size" {
  default = "Standard_D2s_v3"
}

variable "vms" {
  description = "Map of VM names to configuration"
  type = map(object({
    subnet = string
    size   = string
  }))
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type = string
  sensitive = true
}

variable "subnet_ids" {
  description = "Map of subnet names to IDs from VNet module"
  type        = map(string)
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "vnet_dependency" {
  description = "Optional dependency on VNet creation"
  type        = any
}
