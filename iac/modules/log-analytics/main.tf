resource "azurerm_log_analytics_workspace" "law" {
  provider            = azurerm.aiml-nprod-001
  name                = var.law_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.law_sku
  retention_in_days   = var.law_retention_days
  internet_ingestion_enabled = var.law_internet_ingestion
  internet_query_enabled = var.law_internet_query
}