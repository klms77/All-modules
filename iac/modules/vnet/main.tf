resource "azurerm_resource_group" "rg" {
  provider = azurerm.adsprint
  count    = var.create_rg ? 1 : 0
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "this" {
  provider = azurerm.adsprint
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.create_rg ? azurerm_resource_group.rg[0].name : var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet" "subnets" {
  provider = azurerm.adsprint
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = var.create_rg ? azurerm_resource_group.rg[0].name : var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value.address_prefixes
}
