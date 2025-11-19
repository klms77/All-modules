variable "new_rg_location" {
  type        = string
  description = "Region for the New Resource Group"
}

variable "new_rg" {
  type        = string
  description = "Name of the New Resource Group"
}

variable "public_ip_name_ag" {
  description = "Public IP name for Application Gateway"
  type        = string
}

variable "allocation_method" {
  description = "Defines how an IP address is assigned. Possible values are Static or Dynamic."
  type        = string
  default = "Static"
}

variable "pip_sku" {
  description = "The SKU of the Public IP. Accepted values are Basic and Standard."
  type        = string
  default     = "Standard"
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
    default = {
    ApplicationName    = "AIML-Vardo"
    BusinessUnit       = "AIML"
    CI                 = "Subscription"
    CostCenter         = "TBD"
    Environment        = "NONPROD"
    ITApplicationOwner = "brian.dolan@fortrea.com"
  }
}

