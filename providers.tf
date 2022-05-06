terraform {

  required_version = ">=0.12"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}



# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
  }
  skip_provider_registration = true
  subscription_id = "3c77aee9-6f8b-4f87-8ff4-1e85ca74f8be"
  client_id = "7768a3ef-069f-4348-a78f-7746e2ddc693"
  client_secret = "o7HFx6~8qhGlEoNP5Qa-F-Xua2_QT3i40i"
  tenant_id = "cb051081-0828-4f81-b5ae-b6c75a0caa81"

  
}
