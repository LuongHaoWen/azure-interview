data "azuread_client_config" "current" {}
data "azurerm_subscription" "primary" {
}
resource "azuread_application" "interview-app" {
  display_name = "interview-app"
  owners       = [data.azuread_client_config.current.object_id]
}
#create interview-spn
resource "azuread_service_principal" "interview-spn" {
  application_id               = azuread_application.interview-app.application_id
  app_role_assignment_required = true
  owners                       = [data.azuread_client_config.current.object_id]
}


#create a password for spn
resource "azuread_service_principal_password" "SPN_password" {
  service_principal_id = azuread_service_principal.interview-spn.object_id
}

#assign role contributor to spn
resource "azurerm_role_assignment" "interview-spn-role" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Contributor"
  principal_id        = azuread_service_principal.interview-spn.object_id
  skip_service_principal_aad_check = true
}




# create resource group
resource "azurerm_resource_group" "interview-rg" {
  name      = replace("interview-rg-${var.email_name}", "/[[:punct:]]/","-")
  location  = "southeast asia"

}
# Create virtual network
resource "azurerm_virtual_network" "interview-vnet" {
  name                = replace("interview-vnet-${var.email_name}", "/[[:punct:]]/","-")
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.interview-rg.location
  resource_group_name = azurerm_resource_group.interview-rg.name
}


#create subnet

resource "azurerm_subnet" "interview-subnet" {
  name                 = replace("interview-subnet-${var.email_name}", "/[[:punct:]]/","-")
  resource_group_name  = azurerm_resource_group.interview-rg.name
  virtual_network_name = azurerm_virtual_network.interview-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}



 #create network interface
resource "azurerm_network_interface" "interview-ni" {
  name                = replace("interview-ni-${var.email_name}", "/[[:punct:]]/","-")
  location            = azurerm_resource_group.interview-rg.location
  resource_group_name = azurerm_resource_group.interview-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.interview-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}






 




