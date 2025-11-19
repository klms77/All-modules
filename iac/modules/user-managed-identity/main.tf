resource "azurerm_user_assigned_identity" "mid" {
  provider = azurerm.aiml-nprod-001
  location            = var.location
  name                = var.identity_name
  resource_group_name = var.resource_group_name
  tags = var.tags
}

data "azurerm_key_vault" "kv" {
  provider = azurerm.aiml-nprod-001
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "rolekv" {
  provider = azurerm.aiml-nprod-001
  scope                = data.azurerm_key_vault.kv.id
  role_definition_name = var.kvrole_definition_name
  principal_id         = azurerm_user_assigned_identity.mid.principal_id
  depends_on = [
    azurerm_user_assigned_identity.mid
  ]
}

resource "azurerm_role_assignment" "rolekv2" {
  provider = azurerm.aiml-nprod-001
  scope                = data.azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azurerm_user_assigned_identity.mid.principal_id
  depends_on = [
    azurerm_user_assigned_identity.mid
  ]
}

data "azurerm_linux_web_app" "webapp" {
  provider = azurerm.aiml-nprod-001
  name                = var.web_app_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "rolewapp" {
  provider = azurerm.aiml-nprod-001
  scope                = data.azurerm_linux_web_app.webapp.id
  role_definition_name = var.webapp_role_definition_name
  principal_id         = azurerm_user_assigned_identity.mid.principal_id
}

data "azurerm_application_gateway" "agw" {
  provider = azurerm.it-dmz-prod-001
  name                = var.appgw_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "roleagw" {
  provider = azurerm.it-dmz-prod-001
  scope                = data.azurerm_application_gateway.agw.id
  role_definition_name = var.agw_role_definition_name
  principal_id         = azurerm_user_assigned_identity.mid.principal_id
}
