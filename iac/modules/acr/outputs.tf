output "acr_login_server" {
  description = "The login server URL of the ACR"
  value       = azurerm_container_registry.acr.login_server
}

output "acr_id" {
  description = "The resource ID of the ACR"
  value       = azurerm_container_registry.acr.id
}

output "private_endpoint_id" {
  description = "The private endpoint ID"
  value       = azurerm_private_endpoint.acr.id
}
