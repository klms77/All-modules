output "appgw_id" {
  value = azurerm_application_gateway.this.id
}

output "appgw_public_ip" {
  value = azurerm_public_ip.this.ip_address
}