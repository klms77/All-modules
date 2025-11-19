variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region"
  type        = string
}
variable "sku_ai" {}
variable "azure_ai_instance_name" {}
variable "cognitive_account_name" {}


variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default = {
    ApplicationName    = "TBD"
    BusinessUnit       = "TBD"
    CI                 = "TBD"
    CostCenter         = "TBD"
    Environment        = "NONPROD"
    ITApplicationOwner = "TBD"
  }

}