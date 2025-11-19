variable "failover_group_name" {
  type        = string
  description = "Name of the Failover Group"
}

variable "failover_resource_group_name1" {
  type        = string
  description = "Resource Group name of the Primary Region"
}

variable "failover_resource_group_name2" {
  type        = string
  description = "Resource Group name of the Secondary Region"
}

variable "failover_location" {
  type        = string
  description = "Location of the Failover Group"
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

variable "sqlserver1" {
  type        = string
  description = "Name of the Primary SQL Server"
}

variable "sqlserver2" {
  type        = string
  description = "Name of the Secondary SQL Server"
}

variable "db1" {
  type        = string
  description = "Name of the Database from Primary Region"
}

 variable "failover_policy_mode" {
  type        = string
  description = "Read Write endpoint failover policy mode"
  default = "Automatic"
}

variable "primaryregion" {
  type        = string
  description = "Primary Region for SQL Failover group"
}

variable "secondaryregion" {
  type        = string
  description = "Secondary Region for SQL Failover group"
}

variable "application_name" {
  type        = string
  description = "Name of the Application"
}

variable "project" {
  type        = string
  description = "Name of the Project"
}

variable "environment" {
  type        = string
  description = "Name of the Environment"
}

variable "type" {
  type        = string
  description = "Type of Environment"
}

