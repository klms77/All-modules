data "azurerm_private_dns_zone" "sql_dns" {
 provider = azurerm.it-sharedservices-001
  name                = "privatelink.database.windows.net"
  resource_group_name = "rg-dns-prod-001"
}
######################### MS SQL DB #########################
module "sql_server" {
  providers = {
    azurerm.ppnprod = azurerm.ppnprod
  }
  source                  = "./modules/sql-server"
  sql_server_name         = var.sql_server_name
  resource_group_name     = var.resource_group_name
  location                = var.location
  sql_version             = var.sql_version
  admin_login             = var.admin_login
  sql_admin_password      = var.sql_admin_password
  azuread_admin_username  = var.azuread_admin_username
  subnet_id           = var.subnet_id
  private_dns_zone_id = data.azurerm_private_dns_zone.sql_dns.id
  azuread_admin_object_id = var.azuread_admin_object_id
  db_name = var.db_name
  collation = var.collation
  #depends_on = [module.vnet,module.resource_group]
}