variable "resource_group_name" {
  type        = string
  description = "Existing or new Resource Group name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "create_rg" {
  type        = bool
  default     = false
  description = "Set true to create new RG, false to use existing"
}

variable "vnet_name" {
  type        = string
  description = "VNet name"
}

variable "address_space" {
  type        = list(string)
  description = "VNet address space"
}

variable "subnets" {
  type = map(object({
    address_prefixes = list(string)
  }))
  description = "Map of subnets"
}

variable "tags" {
  type    = map(string)
  default = {}
}
