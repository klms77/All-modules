/*# Resource Group outputs
output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "resource_group_location" {
  description = "The location of the resource group"
  value       = azurerm_resource_group.rg.location
}

output "resource_group_id" {
  description = "The ID of the resource group"
  value       = azurerm_resource_group.rg.id
}
output "vnet_id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.vnet_id
}
output "vnet_subnets" {
  description = "The subnets within the virtual network"
  value       = azurerm_virtual_network.vnet.subnets
}*/