output "failover_group_name" {
  description = "The name of the Failover Group"
  value       = azurerm_mssql_failover_group.fogroup.name
}