###################Resource Group configuration########################
resource_group_name = "rg-pp-nonprod-001"
location            = "Westus"

########################vnet configuration###########################
create_vnet         = false
create_rg = false
vnet_name           = "vnet-dev-eastus-002"
address_space       = ["10.1.0.0/16"]
subnets = {
  frontend = { address_prefixes = ["10.1.1.0/24"] }
  backend  = { address_prefixes = ["10.1.2.0/24"] }
  database = { address_prefixes = ["10.1.3.0/24"] }
  pe_subnet = { address_prefixes = ["10.1.4.0/28"] }
}
existing_subnet_names = [ "frontend" ,"backend","database","pe_subnet"]

tags = {
  ApplicationName = "TBD"
 BusinessUnit = "TBD"
 CI = "TBD"
 CostCenter = "TBD"
 Environment = "TBD"
 ITApplicationOwner = "TBD"
 ITCostOwner = "TBD"
}

##########################windows VM configuration#############################
  vms = {
  "vm-frontend-001" = { subnet = "frontend", size = "Standard_B2s" }
  "vm-backend-001"  = { subnet = "backend",  size = "Standard_B2s" }
  "vm-db-001"       = { subnet = "database", size = "Standard_B2s" }
}

admin_username = "azureuser"
admin_password = "Fortrea@2025"

##################################Storage#####################################
storage_account_name   = "iacdemostr008"
shared_access_key_enabled = true

#########################AI_Service########################################
sku_ai = "S0"
azure_ai_instance_name = "ai_fortrea_demo_006"
cognitive_account_name = "ai_cognitive_account_006"

##########################Keyvault#######################################
keyvault_name = "ai-demokvm-006"
tenant_id = "5fbc2afc-b6e7-49ed-a6cf-ea49a27f7c12"
sku_name = "standard"
purge_protection_enabled = false
object_id = "f4642d8d-f277-4c14-b906-27279cc7ff00"

####################################### ACR #########################
acr_name              = "acrspdvalang03"
sku                   = "Premium"
#subnet_id             = "/subscriptions/1111.../resourceGroups/rg-network/providers/Microsoft.Network/virtualNetworks/vnet-core/subnets/snet-pe"
dns_subscription_id   = "29d43faa-10c8-436c-849e-d0d9c1e03a6f"
dns_resource_group    = "rg-dns-prod-001"
target_subscription_id = "fb4941ac-29a4-4aa9-9510-e13b0030d06f"
#private_dns_zone_id = "/subscriptions/29d43faa-10c8-436c-849e-d0d9c1e03a6f/resourceGroups/rg-dns-prod-001/providers/Microsoft.Network/privateDnsZones/privatelink.azurecr.io"
#############################APPG########################
appgw_name               = "agw-iacdemo-dev-eus-003"
appg_resource_group_name      = "rg-appgw-iacdemo-dev-eus-003"

# Existing VNet (in another subscription)
appg_vnet_name                = "vnet-dmz-inet-eastus-001"
vnet_resource_group_name = "rg-network-dmz-inet-eastus-001"

# Subnet details (new subnet under existing VNet)
appgw_subnet_name   = "snet-iacdemo-eus-002"
appgw_subnet_prefix = "10.48.95.176/28"

# Subscriptions
network_subscription_id = "d5fbc7cc-9748-4dfd-9de6-4915eed83bd0"
appgw_subscription_id   = "d5fbc7cc-9748-4dfd-9de6-4915eed83bd0"

# SKU and scaling
appgw_sku_name = "Standard_v2"
appgw_sku_tier = "Standard_v2"
appgw_capacity = 2

########################### SQL Database ###########################
sql_server_name = "sql-ilqr-ppnp-wus-001"
sql_version = "12.0"
admin_login = "sqladmin"
sql_admin_password = "P@ssword1234!"
azuread_admin_username = "sarang.joshi@fortrea.com"
azuread_admin_object_id = "2b18100a-b4ef-4e88-86a4-064b21e7a500"
db_name = "sqldb-ilqr-ppnp-wus-001"
collation = "SQL_Latin1_General_CP1_CI_AS"
sqlsku_name = "S2"
subnet_id = "/subscriptions/d3101287-a713-4aff-af6c-58c0ebca8c20/resourceGroups/rg-ppnetwork-eus-001/providers/Microsoft.Network/virtualNetworks/vnet-ppnp-wus-002/subnets/snet-ppnp-sql-001"
