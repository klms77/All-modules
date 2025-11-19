resource "azurerm_resource_group" "rg" {
  provider            = azurerm.adsprint
  name     = var.resource_group_name
  location = var.location
  tags   = var.tags
}