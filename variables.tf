#leave blank
variable "azurerm_resource_group_name" {
   
  type          = "string"
  default       = "interview-rg"
  description   = " naming "
}

variable "azurerm_resource_group_location" {
   
  type          = "string"
  default       = "southeast asia"
  description   = "location "
}

variable "azurerm_virtual_network_name" {
   
  type          = "string"
  default       = "interview-vnet"
}


variable "azurerm_public_ip_name" {
   
  type          = "string"
  default       = "interview-ip"
}

variable "azurerm_public_ip_allocation_method"{
    type = "string"
    default = "dynamic"
}

variable "azurerm_network_security_group_name"{
    type= "string"
    default = "interview-nsg"

}