variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "service_plan_name" {
  description = "The name of the App Service Plan"
  type        = string
}

variable "web_app_name" {
  description = "The name of the Web App"
  type        = string
}

variable "os_type" {
  description = "The OS type for the App Service Plan"
  type        = string
  default = "Linux"
}
 
variable "aspsku_name" {
  description = "The SKU name of App Service Plan"
  type        = string
  default = "B1"
}

variable "worker_count" {
  description = "The count of Instances of App Service Plan"
  type        = number
  default = 2
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
    default = {
    ApplicationName    = "AIML-Vardo"
    BusinessUnit       = "AIML"
    CI                 = "Subscription"
    CostCenter         = "TBD"
    Environment        = "NONPROD"
    ITApplicationOwner = "brian.dolan@fortrea.com"
  }
}

variable "private_endpoint_web_name" {
  description = "The name of the private endpoint"
  type        = string
}

variable "private_service_connection_web_name" {
  description = "The name of the private service connection"
  type        = string
}

variable "webappsubnetname" {
  description = "The name of the Subnet for Web App"
  type        = string
  default = "snet-pe-001"
}

variable "webappvnetname" {
  description = "The name of the Virtual Network for Web App"
  type        = string
}
variable "webapprgname" {
  description = "The name of the Resource Group for Vnet of Web App"
  type        = string
}

variable "webappsubresource_names" {
  description = "The subresource names for the Web App Private connection"
  type        = list(string)
  default     = ["sites"]
}

variable "webappvnetlink" {
  description = "The name of the Virtual Network Link for Web App"
  type        = string
}

variable "weblinkname" {
  description = "Link name for Web App"
  type        = string
}

 variable "webappdnsrgname" {
  description = "The name of the Resource Group of DNS Zone for Web App"
  type        = string
  default = "rg-dns-prod-001"
}

 variable "webappdnszonename" {
  description = "The name of the DNS Zone for Web App"
  type        = string
  default = "privatelink.azurewebsites.net"
}

variable "webdnsrecordsetname" {
  description = "Recorset name of DNS Zone for Web App"
  type        = string
}

variable "webdnsttl" {
  description = "TTL for DNS Zone of Web App"
  type        = number
  default = 10
}

# variable "secret_value" {
#   description = "The secret value to be stored securely in Key Vault"
#   type        = string
#   sensitive   = true
# }

variable "webintsubnetname" {
  description = "Name of Subnet for Web App Vnet Integration"
  type        = string
  default = "snet-appintegration"
}

variable "webnsg_name" {
  description = "Name of NSG for Web App"
  type        = string
  default = "nsg-snet-appintegration-001"
}

variable "webnsgsubnet" {
  description = "Name of Subnet for NSG of Web App"
  type        = string
  default = "snet-appintegration"
}

  variable "identity_name" {
  description = "The name of the managed identity"
  type        = string
  default = ""
}

# variable "user_object_id" {
#   description = "The Object Id of the User"
#   type        = string
#   sensitive   = true
# }

# variable "tenant_id" {
#   description = "The tenant ID for the Web App"
#   type        = string
#   sensitive   = true
# }


  variable "web_client_affinity_enabled" {
  description = "Client affinity settings for Web App"
  type        = bool
  default = true
  }

  variable "web_client_certificate_enabled" {
  description = "Client certificate settings for Web App"
  type        = bool
  default = false
  }

  variable "web_client_certificate_mode" {
  description = "Client certificate mode for Web App"
  type        = string
  default = "Required"
  }

  variable "web_https_only" {
  description = "HTTPS settings for Web App"
  type        = bool
  default = true
  }

  variable "web_public_network_access_enabled" {
  description = "Public network settings for Web App"
  type        = bool
  default = false
  }

 variable "web_identity_type" {
  description = "Identity type for Web App"
  type        = string
  default = "UserAssigned"
  }

  variable "web_always_on" {
  description = "Site Config Always ON setting for Web App"
  type        = bool
  default = false
  }

  variable "web_http2_enabled" {
  description = "HTTP2 setting for Web App"
  type        = bool
  default = false
  }

  variable "aiml_vardo_eastus_001" {
  description = "Web App settings"
  type        = string
  default = "@Microsoft.KeyVault(VaultName=kv-vardo-dev-eastus-001;SecretName=AIML-vardo-dev-eastus-001)"
  }

  variable "APP_ENV" {
  description = "Web App settings"
  type        = string
  default = "Production"
  }

  variable "APP_VERSION" {
  description = "Web App settings"
  type        = string
  default = "1.0.1"
  }

  variable "PYTHON_VERSION" {
  description = "Web App settings"
  type        = number
  default = 3.12
  }

  variable "WEBSITES_ENABLE_APP_SERVICE_STORAGE" {
  description = "Web App settings"
  type        = bool
  default = false
  }

  variable "web_auth_enabled" {
  description = "Web App Auth enabled settings"
  type        = bool
  default = true
  }

  variable "web_default_provider" {
  description = "Web App default provider"
  type        = string
  default = "AzureActiveDirectory"
  }

  variable "web_unauthenticated_action" {
  description = "Web App unauthenticated action"
  type        = string
  default = "RedirectToLoginPage"
  }

  variable "web_client_secret_setting_name" {
  description = "Web App client secret setting name"
  type        = string
  default = ""
  }

  variable "web_allowed_audiences" {
  description = "Allowed audiences for Web App"
  type        = list(string)
  default     = []
}

  variable "web_token_store_enabled" {
  description = "Toke store setting for Web App"
  type        = bool
  default     = true
}

  variable "web_allowed_external_redirect_urls" {
  description = "Allowed external redirect URLS for Web App"
  type        = list(string)
  default     = []
}   

  variable "web_role_definition_name" {
  description = "Web App role definition name"
  type        = string
  default = "Contributor"
  }