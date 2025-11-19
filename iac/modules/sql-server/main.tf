resource "azurerm_mssql_server" "sql_server" {
  provider = azurerm.ppnprod
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                  = var.sql_version
  administrator_login          = var.admin_login
  administrator_login_password = var.sql_admin_password
  public_network_access_enabled   = false
  azuread_administrator {
    login_username = var.azuread_admin_username
    object_id      = var.azuread_admin_object_id
  }
}
resource "azurerm_mssql_database" "sql_db" {
  provider = azurerm.ppnprod
  name      = var.db_name
  server_id = azurerm_mssql_server.sql_server.id
  collation = var.collation
  sku_name  = var.sqlsku_name
  depends_on = [ azurerm_mssql_server.sql_server]
}

######## SQL Private Endpoint #############

resource "azurerm_private_endpoint" "sql_pe" {
  provider = azurerm.ppnprod
  name                = "${var.sql_server_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.sql_server_name}-pe"
    private_connection_resource_id = azurerm_mssql_server.sql_server.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [var.private_dns_zone_id]
  }
}
