resource "azurerm_key_vault" "this" {
  provider            = azurerm.adsprint
  name                        = var.keyvault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = var.sku_name
  #soft_delete_enabled         = true
  purge_protection_enabled    = var.purge_protection_enabled

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id

    key_permissions = ["Get"]
    secret_permissions = ["Get","List"]
  }

  tags = var.tags
}