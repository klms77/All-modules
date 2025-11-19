# Create RG for App Gateway (in its subscription)
resource "azurerm_resource_group" "this" {
  provider = azurerm.it-dmz-prod-001
  name     = var.appg_resource_group_name
  location = var.location
}

# --- Subnet for Application Gateway ---
resource "azurerm_subnet" "appgw_subnet" {
  provider = azurerm.it-dmz-prod-001
  name                 = var.appgw_subnet_name
  resource_group_name  = var.vnet_resource_group_name
  virtual_network_name = var.appg_vnet_name
  address_prefixes     = [var.appgw_subnet_prefix]
}

# --- Public IP for AppGW Frontend ---
resource "azurerm_public_ip" "this" {
  provider = azurerm.it-dmz-prod-001
  name                = "${var.appgw_name}-pip"
  location            = var.location
  resource_group_name = var.appg_resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

# --- Application Gateway ---
resource "azurerm_application_gateway" "this" {
  provider = azurerm.it-dmz-prod-001
  name                = var.appgw_name
  location            = var.location
  resource_group_name = var.appg_resource_group_name
  sku {
    name     = var.appgw_sku_name
    tier     = var.appgw_sku_tier
    capacity = var.appgw_capacity
  }

  gateway_ip_configuration {
    name      = "appgw-ipconfig"
    subnet_id = azurerm_subnet.appgw_subnet.id
  }

  frontend_port {
    name = "frontendPort"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "appgw-feip"
    public_ip_address_id = azurerm_public_ip.this.id
  }

  backend_address_pool {
    name = "default-pool"
  }

  backend_http_settings {
    name                  = "default-http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 30
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "appgw-feip"
    frontend_port_name             = "frontendPort"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "default-pool"
    backend_http_settings_name = "default-http-settings"
    priority = "100"
  }

  tags = var.tags
}
