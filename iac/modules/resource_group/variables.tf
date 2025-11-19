variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default = {
    ApplicationName    = "FCS-infra-Ops"
    BusinessUnit       = "CyberSecurity"
    CI                 = "TBD"
    CostCenter         = "8811"
    Environment        = "PROD"
    ITApplicationOwner = "john schieferleuhlenbrock"
    ITCostOnwer        = "jim cameli"
  }
}