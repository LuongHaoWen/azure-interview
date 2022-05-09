#resource group variables
variable "azurerm_resource_group_name" {
  type          = string
  default       = "interview-rg"
  description   = " naming "
}

variable "azurerm_resource_group_location" {
  type          = string
  default       = "southeast asia"
  description   = "location "
}
#virtual network variables
variable "azurerm_virtual_network_name" {
  type          = string
  default       = "interview-vnet"
}

#public ip variables 
variable "azurerm_public_ip_name" {
  type          = string
  default       = "interview-ip"
}

variable "azurerm_public_ip_allocation_method"{
    type = string
    default = "dynamic"
}
#netowrk security group variables
variable "azurerm_network_security_group_name"{
    type= string
    default = "interview-nsg"
}

variable "azurerm_network_interface"{
   type = string
   default = "interview-ni"
}