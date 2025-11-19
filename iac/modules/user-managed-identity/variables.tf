variable "identity_name" {
  description = "The name of the managed identity"
  type        = string
}

variable "location" {
  type        = string
  description = "Region for the infrastructure deployment"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group"
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

variable "key_vault_name" {
  description = "The name of the Key Vault"
  type        = string
  default = ""
}

variable "web_app_name" {
  description = "The name of the Web App"
  type        = string
  default = ""
}

variable "appgw_name" {
  description = "The name of the Application Gateway"
  type        = string
  default = ""
}

variable "kvrole_definition_name" {
  description = "Key Vault role definition name"
  type        = string
  default = "Key Vault Secrets Officer"
}

variable "webapp_role_definition_name" {
  description = "Web App role definition name"
  type        = string
  default = "Contributor"
}

variable "agw_role_definition_name" {
  description = "Application Gateway role definition name"
  type        = string
  default = "Contributor"
}