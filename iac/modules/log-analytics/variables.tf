variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "law_name" {
  description = "The name of the Log Analytics Workspace"
  type        = string
  default = ""
}

variable "law_sku" {
  description = "The SKU of the Log Analytics Workspace"
  type        = string
  default = "PerGB2018"
}

variable "law_retention_days" {
  description = "The retention days for Log Analytics Workspace"
  type        = number
  default = 30
}

variable "law_internet_ingestion" {
  description = "The Internet ingestion setting for Log Analytics Workspace"
  type        = bool
  default = true
}

variable "law_internet_query" {
  description = "The Internet Query setting for Log Analytics Workspace"
  type        = bool
  default = true
}