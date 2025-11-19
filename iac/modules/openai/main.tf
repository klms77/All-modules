# locals {
#   account_name          = coalesce(var.account_name, var.openainame)
#   custom_subdomain_name = coalesce(var.custom_subdomain_name, var.openainame)
# }

# locals {
#   subnets = {
#     subnet1 = {
#       name           = "snet-appintegration" # Replace with your subnet name
#       address_prefix = "10.48.87.0/27"       # Replace with your address prefix
#     },
#     subnet2 = {
#       name           = "snet-pe-001"    # Replace with your subnet name
#       address_prefix = "10.48.87.64/27" # Replace with your address prefix
#     }
#   }
# }

# data "azurerm_user_assigned_identity" "uid" {
#   provider            = azurerm.aiml-nprod-001
#   name                = var.identity_name
#   resource_group_name = var.resource_group_name
# }

# data "azurerm_subnet" "subnet" {
#   provider             = azurerm.aiml-nprod-001
#   name                 = "snet-appintegration"
#   virtual_network_name = var.ai_vnet_name
#   resource_group_name  = var.ai_rg_name
# }

# data "azurerm_subnet" "subnet2" {
#   provider             = azurerm.aiml-nprod-001
#   name                 = "snet-pe-001"
#   virtual_network_name = var.ai_vnet_name
#   resource_group_name  = var.ai_rg_name
# }

# data "azurerm_subnet" "subnets" {
#   provider = azurerm.aiml-nprod-001
#   for_each = local.subnets

#   name                 = each.value.name
#   virtual_network_name = var.ai_vnet_name # Replace with your virtual network name
#   resource_group_name  = var.ai_rg_name   # Replace with your resource group name
# }

# resource "azurerm_cognitive_account" "this" {
#   provider                           = azurerm.aiml-nprod-001
#   kind                               = "OpenAI"
#   location                           = var.location
#   name                               = local.account_name
#   resource_group_name                = var.resource_group_name
#   sku_name                           = var.aisku_name
#   custom_subdomain_name              = local.custom_subdomain_name
#   dynamic_throttling_enabled         = var.dynamic_throttling_enabled
#   fqdns                              = var.fqdns
#   local_auth_enabled                 = var.local_auth_enabled
#   outbound_network_access_restricted = var.outbound_network_access_restricted
#   # public_network_access_enabled      = var.public_network_access_enabled
#   tags = var.tags

#   dynamic "identity" {
#     for_each = var.identity != null ? [var.identity] : []
#     content {
#       type         = identity.value.type
#       identity_ids = [data.azurerm_user_assigned_identity.uid.id]
#     }
#   }



#   network_acls {
#     default_action = var.network_access_option == "all" ? "Allow" : "Deny"
#     # bypass         = var.network_access_option == "all" ? ["AzureServices"] : ["None"]

#     ip_rules = var.network_access_option == "selected" ? ["59.184.232.219"] : []
#     dynamic "virtual_network_rules" {
#       # for_each = var.network_acls.virtual_network_rules != null ? var.network_acls.virtual_network_rules : []
#       for_each = var.network_access_option == "selected" ? var.network_acls.virtual_network_rules : []
#       content {

#         #subnet_id                            = virtual_network_rules.value.subnet_id
#         subnet_id                            = data.azurerm_subnet.subnets[virtual_network_rules.value.subnet_id].id
#         ignore_missing_vnet_service_endpoint = virtual_network_rules.value.ignore_missing_vnet_service_endpoint
#       }

#     }
#   }

#   public_network_access_enabled = var.network_access_option == "all" ? true : false


#   #   dynamic "storage" {
#   #     for_each = var.storage
#   #     content {
#   #       storage_account_id = storage.value.storage_account_id
#   #       identity_client_id = storage.value.identity_client_id
#   #     }
#   #   }

#   # depends_on = [
#   #   azurerm_key_vault_key.generated
#   # ]
# }

# resource "azurerm_cognitive_deployment" "this" {
#   provider = azurerm.aiml-nprod-001
#   for_each = var.deployment

#   cognitive_account_id = azurerm_cognitive_account.this.id
#   name                 = each.value.name
#   rai_policy_name      = each.value.rai_policy_name

#   model {
#     format  = each.value.model_format
#     name    = each.value.model_name
#     version = each.value.model_version
#   }
#   #   scale {
#   #     type = each.value.scale_type
#   #   }
#   sku {
#     name     = "GlobalStandard"
#     capacity = 10
#   }
#   depends_on = [
#     azurerm_cognitive_account.this
#   ]
# }

# resource "azurerm_private_endpoint" "pep" {
#   provider            = azurerm.aiml-nprod-001
#   name                = var.ai_pep_name
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   subnet_id           = data.azurerm_subnet.subnet2.id


#   private_service_connection {
#     name                           = var.ai_pep_name
#     private_connection_resource_id = azurerm_cognitive_account.this.id
#     subresource_names              = ["account"]
#     is_manual_connection           = false
#   }

#   depends_on = [
#     azurerm_cognitive_account.this
#   ]
# }

# data "azurerm_key_vault" "kv" {
#   provider            = azurerm.aiml-nprod-001
#   name                = var.key_vault_name
#   resource_group_name = var.resource_group_name
# }

# data "azurerm_key_vault_key" "kvk" {
#   provider     = azurerm.aiml-nprod-001
#   name         = var.key_name
#   key_vault_id = data.azurerm_key_vault.kv.id
# }


# resource "azurerm_cognitive_account_customer_managed_key" "cmkey" {
#   provider             = azurerm.aiml-nprod-001
#   cognitive_account_id = azurerm_cognitive_account.this.id
#   key_vault_key_id     = data.azurerm_key_vault_key.kvk.id
#   identity_client_id   = data.azurerm_user_assigned_identity.uid.client_id
#   depends_on = [
#     data.azurerm_key_vault_key.kvk
#   ]
# }

# resource "azurerm_network_security_group" "nsg" {
#   provider            = azurerm.aiml-nprod-001
#   name                = var.ai_nsg_name
#   location            = var.location
#   resource_group_name = var.ai_rg_name

#   dynamic "security_rule" {
#     for_each = var.security_rules
#     content {
#       name                       = security_rule.value.name
#       priority                   = security_rule.value.priority
#       direction                  = security_rule.value.direction
#       access                     = security_rule.value.access
#       protocol                   = security_rule.value.protocol
#       source_port_range          = security_rule.value.source_port_range
#       destination_port_range     = security_rule.value.destination_port_range
#       source_address_prefix      = security_rule.value.source_address_prefix
#       destination_address_prefix = security_rule.value.destination_address_prefix
#     }
#   }


#   tags = var.tags
#   depends_on = [
#     azurerm_cognitive_account.this
#   ]
# }

# #Associate NSG to Open AI 
# data "azurerm_subnet" "nsgsubnet" {
#   provider             = azurerm.aiml-nprod-001
#   name                 = var.ai_subnet_name
#   virtual_network_name = var.ai_vnet_name
#   resource_group_name  = var.ai_rg_name
# }

# # data "azurerm_network_security_group" "nsg" {
# #   provider            = azurerm.aiml-nprod-001
# #   name                = var.ai_nsg_name
# #   resource_group_name = var.ai_rg_name
# # }

# resource "azurerm_subnet_network_security_group_association" "nsgasso" {
#   provider                  = azurerm.aiml-nprod-001
#   subnet_id                 = data.azurerm_subnet.nsgsubnet.id
#   network_security_group_id = azurerm_network_security_group.nsg.id
#   depends_on = [
#     azurerm_network_security_group.nsg
#   ]
# }


