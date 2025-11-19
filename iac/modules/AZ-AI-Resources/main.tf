resource "azurerm_cognitive_account" "cognitive_service" {
  provider            = azurerm.adsprint
  name                = var.cognitive_account_name
  location            = var.location
  resource_group_name = var.resource_group_name
  #sku_ai            = var.sku_ai
  sku_name = var.sku_ai
  kind                = "CognitiveServices"
}
resource "azurerm_ai_services" "fortai" {
  provider            = azurerm.adsprint
  name                = var.azure_ai_instance_name
  location            = var.location
  resource_group_name = var.resource_group_name
    #sku_ai            = var.sku_ai
  sku_name = var.sku_ai
  tags                = var.tags
  
}
