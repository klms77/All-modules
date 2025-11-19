data "azurerm_mssql_server" "sqlserver1" {
  name                = var.sqlserver1
  resource_group_name = var.failover_resource_group_name1
}

data "azurerm_mssql_server" "sqlserver2" {
  name                = var.sqlserver2
  resource_group_name = var.failover_resource_group_name2
}

data "azurerm_mssql_database" "db1" {
  name      = var.db1
  server_id = data.azurerm_mssql_server.sqlserver1.id
}

resource "azurerm_mssql_failover_group" "fogroup" {
  name      = var.failover_group_name
  server_id = data.azurerm_mssql_server.sqlserver1.id
  databases = [
    data.azurerm_mssql_database.db1.id
  ]

  partner_server {
    id = data.azurerm_mssql_server.sqlserver2.id
  }

  read_write_endpoint_failover_policy {
    mode          = var.failover_policy_mode
    grace_minutes = 80
  }

   tags = var.tags

   depends_on = [
    data.azurerm_mssql_server.sqlserver1,
    data.azurerm_mssql_server.sqlserver2,
    data.azurerm_mssql_database.db1
  ]
}