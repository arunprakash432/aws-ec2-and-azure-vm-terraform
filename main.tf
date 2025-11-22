# This is simple azure virtual machine 

resource "azurerm_resource_group" "rg" {
  name     = "example-resources"
  location = "Central India"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "public_ip" {
  name                = "example-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  allocation_method   = "Static" 
  sku                 = "Standard"   # Basic allows dynamic
}

resource "azurerm_network_interface" "nic" {
  name                = "example-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "example-ubuntu-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B1s"

  admin_username      = "azureuser"
  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]
 
  admin_ssh_key {
   username   = "azureuser"
   public_key = file("~/.ssh/id_rsa.pub")
 }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

# this is simple aws ec2 instance

resource "aws_instance" "this" {
  ami                     = "ami-02b8269d5e85954ef"
  instance_type           = "t3.small"
  key_name = "lab-server"

  tags = {
    environment = "dev"
  }
}
