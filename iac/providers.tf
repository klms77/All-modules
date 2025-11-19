terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.20.0"
    }
  }

  backend "azurerm" {
    subscription_id      = "01f80ea1-e021-4e3c-ad77-3a7e68205304"
    resource_group_name  = "rg-tf-eastus-001"
    storage_account_name = "satfeastus001"
    container_name       = "terraformstate"
    key                  = "ppnprod_sql.tfstate"
    use_azuread_auth     = true
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  alias           = "it-sharedservices-001"
  subscription_id = "29d43faa-10c8-436c-849e-d0d9c1e03a6f"
  features {}
}
provider "azurerm" {
  alias           = "ppnprod"
  subscription_id = "d3101287-a713-4aff-af6c-58c0ebca8c20"
  features {}
}

