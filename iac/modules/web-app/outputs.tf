output "service_plan_id" {
  description = "The ID of the App Service Plan"
  value       = azurerm_service_plan.asp.id
}

output "web_app_id" {
  description = "The ID of the Web App"
  value       = azurerm_linux_web_app.webapp.id
}