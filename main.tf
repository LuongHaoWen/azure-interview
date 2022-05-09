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

#create subnet

resource "azurerm_subnet" "interview-subnet" {
  name                 = "interview-subnet"
  resource_group_name  = azurerm_resource_group.interview-rg.name
  virtual_network_name = azurerm_virtual_network.interview-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
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
 #create network interface
resource "azurerm_network_interface" "interview-ni" {
  name                = "interview-ni"
  location            = azurerm_resource_group.interview-rg.location
  resource_group_name = azurerm_resource_group.interview-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.interview-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}



# Create virtual machine disk 
resource "azurerm_managed_disk" "interview-osdisk"{
    name = "interview-os-disk"
    location = azurerm_resource_group.interview-rg.location
    resource_group_name = azurerm_resource_group.interview-rg.name
    storage_account_type = "Standard_LRS"
    create_option        = "Empty"
    disk_size_gb         = "1"
}


#create virtual machine

resource "azurerm_virtual_machine" "interview-vm" {
  name                  = "interview-vm"
  location              = azurerm_resource_group.interview-rg.location
  resource_group_name   = azurerm_resource_group.interview-rg.name
  network_interface_ids = [azurerm_network_interface.interview-ni.id]
  vm_size               = "Standard_F1"

  storage_os_disk {

    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
 
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}













#attach the disk created
resource "azurerm_virtual_machine_data_disk_attachment" "disk-attach" {
  managed_disk_id    = azurerm_managed_disk.interview-osdisk.id
  virtual_machine_id = azurerm_virtual_machine.interview-vm.id
  lun                = "10"
  caching            = "ReadWrite"
}
