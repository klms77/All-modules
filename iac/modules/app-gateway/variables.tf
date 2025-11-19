variable "appgw_name" {
  description = "Application Gateway name"
  type        = string
}

variable "appg_resource_group_name" {
  description = "Name of new resource group for App Gateway"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "appgw_sku_name" {
  description = "App Gateway SKU name (Standard_v2, WAF_v2)"
  type        = string
  default     = "Standard_v2"
}

variable "appgw_sku_tier" {
  description = "App Gateway SKU tier (Standard_v2 or WAF_v2)"
  type        = string
  default     = "Standard_v2"
}

variable "appgw_capacity" {
  description = "Instance count for App Gateway"
  type        = number
  default     = 2
}

variable "appg_vnet_name" {
  description = "Existing VNet name (in another subscription)"
  type        = string
}

variable "vnet_resource_group_name" {
  description = "Resource Group name of existing VNet"
  type        = string
}

variable "appgw_subnet_name" {
  description = "Name for the new subnet for App Gateway"
  type        = string
}

variable "appgw_subnet_prefix" {
  description = "Address prefix for App Gateway subnet"
  type        = string
}

variable "tags" {
  description = "Tags for all resources"
  type        = map(string)
  default     = {}
}
