# data "azurerm_key_vault" "kv" {
#   provider            = azurerm.aiml-nprod-001
#   name                = var.key_vault_name
#   resource_group_name = var.resource_group_name
# }

# resource "azurerm_key_vault_key" "generated" {
#   provider     = azurerm.aiml-nprod-001
#   name         = var.key_name
#   key_vault_id = data.azurerm_key_vault.kv.id
#   key_type     = var.key_type
#   key_size     = var.key_size

#   key_opts = var.key_opts

#   rotation_policy {
#     automatic {
#       time_before_expiry = var.time_before_expiry
#     }

#     expire_after         = var.expire_after
#     notify_before_expiry = var.notify_before_expiry
#   }
# }