variable "acr_name" {
  description = "Name of the ACR"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where ACR is created"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "sku" {
  description = "ACR SKU (Basic, Standard, Premium)"
  type        = string
  default     = "Premium"
}

variable "admin_enabled" {
  description = "Enable admin account for ACR"
  type        = bool
  default     = false
}

variable "subnet_id" {
  description = "Subnet ID for the private endpoint"
  type        = string
}

variable "private_dns_zone_id" {
  description = "Private DNS Zone ID (can be from another subscription)"
  type        = string
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}
