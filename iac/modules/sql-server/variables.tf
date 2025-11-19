variable "sql_server_name" {}
variable "resource_group_name" {}
variable "location" {}
variable "sql_version" {}
variable "admin_login" {}
variable "sql_admin_password" {}
variable "azuread_admin_username" {}
variable "azuread_admin_object_id" {}
variable "db_name" {}
#variable "sql_server_id" {}
variable "collation" {
  default = "SQL_Latin1_General_CP1_CI_AS"
}
variable "sqlsku_name" {
  default = "S0"
}
 variable "subnet_id" {
  description = "Subnet ID for private endpoint"
  type        = string
}

variable "private_dns_zone_id" {
  description = "Private DNS zone ID for blob (can be cross-subscription)"
  type        = string
}
