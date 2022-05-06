# create resource group
resource "azurerm_resource_group" "interview-rg" {
  name      = "interview-rg"
  location  = "southeast asia"
}
# Create virtual network
resource "azurerm_virtual_network" "interview-vnet" {
  name                = "interview-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.interview-rg.location
  resource_group_name = azurerm_resource_group.interview-rg.name
}

# Create public IPs
resource "azurerm_public_ip" "interview-ip" {
  name                = "interview-ip"
  location            = azurerm_resource_group.interview-rg.location
  resource_group_name = azurerm_resource_group.interview-rg.name
  allocation_method   = "Dynamic"
}
# Create Network Security Group and rule
resource "azurerm_network_security_group" "interview-nsg" {
  name                = "interview-nsg"
  location            = azurerm_resource_group.interview-rg.location
  resource_group_name = azurerm_resource_group.interview-rg.name
  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Connect the security group to the network interface


# Create virtual machine disk 
resource "azurerm_managed_disk" "interview-osdisk"{
    name = "interview-os-disk"
    location = azurerm_resource_group.interview-rg.location
    resource_group_name = azurerm_resource_group.interview-rg.name
    storage_account_type = "Standard_LRS"
    create_option        = "Empty"
    disk_size_gb         = "1"
}


