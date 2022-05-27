terraform {

  required_version = ">=0.12"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "interview-spn-storage"
    storage_account_name = "hwspnstorage"
    container_name       = "spncontainer"
    key                  = "terraform.tfstate"
  }
}



# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
  }
  skip_provider_registration = true
  subscription_id = "3c77aee9-6f8b-4f87-8ff4-1e85ca74f8be"


  
}
