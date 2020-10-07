provider "azurerm" {
  features {}
}

locals {
  short_region = substr(var.azure_region, 0, 3)
  service_name = "${var.organisation}-${var.project}-${var.environment}-${local.short_region}"
}

resource "azurerm_resource_group" "resource_group" {
  name     = local.service_name
  location = var.azure_region
}

resource "azurerm_public_ip" "net_public_ip" {
  name                         = "${local.service_name}-public-ip"
  location                     = var.azure_region
  resource_group_name          = azurerm_resource_group.resource_group.name
  allocation_method            = "Dynamic"
  tags = {
    org = var.organisation
    environment = var.environment
    project  = var.project
    service_name = local.service_name
  }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "net_sg" {
    name                            = local.service_name
    location                        = var.azure_region
    resource_group_name             = azurerm_resource_group.resource_group.name

    security_rule {
      name                       = "SSH"
      priority                   = 1001
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = var.ssh_port
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }

  tags = {
    org = var.organisation
    environment = var.environment
    project  = var.project
    service_name = local.service_name
  }
}

# Create virtual network
resource "azurerm_virtual_network" "net_virtual_network" {
    name                    = local.service_name
    address_space           = var.network_cidr_range
    location                = var.azure_region
    resource_group_name     = azurerm_resource_group.resource_group.name

  tags = {
    org = var.organisation
    environment = var.environment
    project  = var.project
    service_name = local.service_name
  }
}

# Create subnet
resource "azurerm_subnet" "net_subnet" {
    name                    = local.service_name
    resource_group_name     = azurerm_resource_group.resource_group.name
    virtual_network_name    = azurerm_virtual_network.net_virtual_network.name
    address_prefixes        = var.network_subnet_prefixes
}

# Create network interface
resource "azurerm_network_interface" "net_nic" {
    name                      = local.service_name
    location                  = var.azure_region
    resource_group_name       = azurerm_resource_group.resource_group.name

    ip_configuration {
        name                          = local.service_name
        subnet_id                     = azurerm_subnet.net_subnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.net_public_ip.id
    }

  tags = {
    org = var.organisation
    environment = var.environment
    project  = var.project
    service_name = local.service_name
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "machine_sga" {
    network_interface_id      = azurerm_network_interface.net_nic.id
    network_security_group_id = azurerm_network_security_group.net_sg.id
}

# Generate random text for a unique storage account name
resource "random_id" "machine_random_id" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group = azurerm_resource_group.resource_group.name
    }

    byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "storage_account" {
    name                        = "hash${random_id.machine_random_id.hex}"
    resource_group_name         = azurerm_resource_group.resource_group.name
    location                    = var.azure_region
    account_tier                = "Standard"
    account_replication_type    = "LRS"

  tags = {
    org = var.organisation
    environment = var.environment
    project  = var.project
    service_name = local.service_name
  }
}

resource "tls_private_key" "machine_ssh" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "azurerm_linux_virtual_machine" "the_machine" {
  resource_group_name             = azurerm_resource_group.resource_group.name
  name                            = local.service_name
  location                        = var.azure_region
  computer_name                   = local.service_name
  disable_password_authentication = true
  network_interface_ids           = [azurerm_network_interface.net_nic.id]
  size                            = var.size
  admin_username                  = var.admin_username
  
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
      publisher = var.os_publisher
      offer     = var.os_offer
      sku       = var.os_sku
      version   = var.os_version
  }
  
  admin_ssh_key {
      username       = var.admin_username
      public_key     = tls_private_key.machine_ssh.public_key_openssh
  }

  tags = {
    org = var.organisation
    environment = var.environment
    project  = var.project
    service_name = local.service_name
  }

}