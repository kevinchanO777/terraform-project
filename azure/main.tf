# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "dev_rg" {
  name     = var.resource_group_name
  location = "eastasia"
}

# Create a virtual network
resource "azurerm_virtual_network" "dev_vnet" {
  name                = "Dev-Machine-Virtual-Network"
  address_space       = ["10.0.0.0/16"]
  location            = "eastasia"
  resource_group_name = azurerm_resource_group.dev_rg.name
}

# Create a subnet for VNet
resource "azurerm_subnet" "dev_subnet1" {
  name                 = "ineternal"
  resource_group_name  = azurerm_resource_group.dev_rg.name
  virtual_network_name = azurerm_virtual_network.dev_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create a public ip address
resource "azurerm_public_ip" "dev_public_ip" {
  name                = "dev${var.dev_number}-ip"
  resource_group_name = azurerm_resource_group.dev_rg.name
  location            = azurerm_resource_group.dev_rg.location
  allocation_method   = "Dynamic"
}

# Create a network interface
resource "azurerm_network_interface" "dev_nic" {
  name                = "dev-nic"
  location            = "eastasia"
  resource_group_name = azurerm_resource_group.dev_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.dev_subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.dev_public_ip.id
  }
}

# Create a virtual machine
resource "azurerm_linux_virtual_machine" "dev_vm" {
  name                = "dev${var.dev_number}"
  resource_group_name = azurerm_resource_group.dev_rg.name
  location            = "eastasia"
  size                = "Standard_B1s"
  admin_username      = var.admin_username

  network_interface_ids = [azurerm_network_interface.dev_nic.id]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.path_to_public_key)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS" # OS disk type
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}