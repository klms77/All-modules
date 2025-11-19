output "public_ip_id" {
    description = "The ID of the Public IP"
  value = azurerm_public_ip.pip.id
}

output "public_ip_address" {
     description = "Public IP Address"
  value = azurerm_public_ip.pip.ip_address
}