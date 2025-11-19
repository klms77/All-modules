resource "azurerm_public_ip" "pip" {
  name                = var.public_ip_name_ag
  location            = var.new_rg_location
  resource_group_name = var.new_rg
  allocation_method   = var.allocation_method
  sku                 = var.pip_sku
  tags                = var.tags
  lifecycle {
    prevent_destroy = true
  }
}