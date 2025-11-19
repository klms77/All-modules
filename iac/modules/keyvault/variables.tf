variable "keyvault_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "tenant_id" {}
variable "sku_name" {
  default = "standard"
}
variable "purge_protection_enabled" {
  default = false
}
variable "object_id" {}
variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default = {
    ApplicationName    = "TBD"
  BusinessUnit       = "TBD"
  CI                 = "TBD"
  CostCenter         = "TBD"
  Environment        = "TBD"
  ITApplicationOwner = "TBD"
  ITCostOwner        = "TBD"
  }

}