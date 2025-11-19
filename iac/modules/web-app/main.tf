data "azurerm_subnet" "subnetsql" {
  #provider             = azurerm.aiml-nprod-001
  name                 = var.webappsubnetname
  virtual_network_name = var.webappvnetname
  resource_group_name  = var.webapprgname
}

# Data source to get the virtual network
data "azurerm_virtual_network" "vnet" {
  #provider            = azurerm.aiml-nprod-001
  name                = var.webappvnetname
  resource_group_name = var.webapprgname
}

data "azurerm_client_config" "current" {
  provider = azurerm.aiml-nprod-001
}

#data block for vnet integration subnet id
data "azurerm_subnet" "subnetapp" {
  #provider             = azurerm.aiml-nprod-001
  name                 = var.webintsubnetname
  virtual_network_name = var.webappvnetname
  resource_group_name  = var.webapprgname
}

data "azurerm_user_assigned_identity" "uid" {
  #provider            = azurerm.aiml-nprod-001
  name                = var.identity_name
  resource_group_name = var.resource_group_name
}


resource "azurerm_service_plan" "asp" {
  #provider            = azurerm.aiml-nprod-001
  name                = var.service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.aspsku_name
  worker_count        = var.worker_count
  tags                = var.tags
}

resource "azurerm_linux_web_app" "webapp" {
  #provider                      = azurerm.aiml-nprod-001
  name                          = var.web_app_name
  resource_group_name           = var.resource_group_name
  location                      = azurerm_service_plan.asp.location
  service_plan_id               = azurerm_service_plan.asp.id
  client_affinity_enabled       = var.web_client_affinity_enabled
  client_certificate_enabled    = var.web_client_certificate_enabled
  client_certificate_mode       = var.web_client_certificate_mode
  https_only                    = var.web_https_only
  public_network_access_enabled = var.web_public_network_access_enabled

  identity {
    type         = var.web_identity_type
    identity_ids = [data.azurerm_user_assigned_identity.uid.id]
  }

  site_config {
    always_on     = var.web_always_on
    http2_enabled = var.web_http2_enabled
  }


  tags = var.tags

  app_settings = {
    aiml_vardo_eastus_001                    = var.aiml_vardo_eastus_001
    APP_ENV                                  =  var.APP_ENV
    APP_VERSION                              =  var.APP_VERSION
    # "MICROSOFT_PROVIDER_AUTHENTICATION_SECRET" = var.secret_value
    PYTHON_VERSION                           =  var.PYTHON_VERSION
    WEBSITE_AUTH_AAD_ALLOWED_TENANTS         = data.azurerm_client_config.current.tenant_id
    WEBSITES_ENABLE_APP_SERVICE_STORAGE      = var.WEBSITES_ENABLE_APP_SERVICE_STORAGE
  }

  auth_settings_v2 {
    auth_enabled           = var.web_auth_enabled
    default_provider       = var.web_default_provider
    unauthenticated_action = var.web_unauthenticated_action


    active_directory_v2 {
      client_id                  = data.azurerm_client_config.current.client_id
      client_secret_setting_name = var.web_client_secret_setting_name
      tenant_auth_endpoint       = "https://login.microsoftonline.com/${data.azurerm_client_config.current.tenant_id}/v2.0"
      allowed_audiences          = var.web_allowed_audiences
    }

    login {
      # Add any necessary configuration here
      token_store_enabled = var.web_token_store_enabled
      allowed_external_redirect_urls = var.web_allowed_external_redirect_urls
    }
  }

  depends_on = [
    azurerm_service_plan.asp
  ]

}

resource "azurerm_role_assignment" "web_role1" {
  #provider             = azurerm.aiml-nprod-001
  scope                = azurerm_linux_web_app.webapp.id
  role_definition_name = var.web_role_definition_name
  principal_id         = data.azurerm_client_config.current.object_id # User Object ID

  depends_on = [
    azurerm_linux_web_app.webapp
  ]
}

resource "azurerm_private_endpoint" "pep" {
  #provider            = azurerm.aiml-nprod-001
  name                = var.private_endpoint_web_name
  location            = var.location
  resource_group_name = var.webapprgname
  subnet_id           = data.azurerm_subnet.subnetsql.id

  private_service_connection {
    name                           = var.private_service_connection_web_name
    private_connection_resource_id = azurerm_linux_web_app.webapp.id
    is_manual_connection           = false
    subresource_names              = var.webappsubresource_names
  }

  tags = var.tags

  depends_on = [
    azurerm_linux_web_app.webapp
  ]
}

# Link the private endpoint to the DNS zone
resource "azurerm_private_dns_zone_virtual_network_link" "vnetlink" {
  #provider              = azurerm.it-sharedservices-001
  name                  = var.weblinkname
  resource_group_name   = var.webappdnsrgname
  private_dns_zone_name = var.webappdnszonename
  virtual_network_id    = data.azurerm_virtual_network.vnet.id

  tags = var.tags
}

#Data source to get the Private Endpoint IP Address
data "azurerm_private_endpoint_connection" "pepconn" {
  #provider            = azurerm.aiml-nprod-001
  name                = var.private_endpoint_web_name
  resource_group_name = var.webapprgname
  depends_on = [
    azurerm_private_endpoint.pep
  ]
}

#Adding Recordset to the DNS zone
resource "azurerm_private_dns_a_record" "dnsrecordset" {
  #provider            = azurerm.it-sharedservices-001
  name                = var.webdnsrecordsetname
  zone_name           = var.webappdnszonename
  resource_group_name = var.webappdnsrgname
  ttl                 = var.webdnsttl
  records             = [data.azurerm_private_endpoint_connection.pepconn.private_service_connection[0].private_ip_address]
  tags                = var.tags

  depends_on = [
    azurerm_private_endpoint.pep
  ]

}

resource "azurerm_app_service_virtual_network_swift_connection" "vnetint" {
  #provider       = azurerm.aiml-nprod-001
  app_service_id = azurerm_linux_web_app.webapp.id
  subnet_id      = data.azurerm_subnet.subnetapp.id

  depends_on = [
    azurerm_linux_web_app.webapp
  ]
}

# data "azurerm_network_security_group" "nsg" {
#   provider            = azurerm.aiml-nprod-001
#   name                = var.webnsg_name
#   resource_group_name = var.webapprgname
# }

# data "azurerm_subnet" "subnetweb" {
#   provider            = azurerm.aiml-nprod-001
#   name                 = var.webnsgsubnet
#   virtual_network_name = var.webappvnetname
#   resource_group_name  = var.webapprgname
# }

# resource "azurerm_subnet_network_security_group_association" "nsgasso" {
#   provider            = azurerm.aiml-nprod-001
#   subnet_id                 = data.azurerm_subnet.subnetweb.id
#   network_security_group_id = data.azurerm_network_security_group.nsg.id

#   depends_on = [
#     azurerm_linux_web_app.webapp
#   ]
# }
