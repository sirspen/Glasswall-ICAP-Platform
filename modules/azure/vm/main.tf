
# Create network interface
resource "azurerm_network_interface" "net_nic" {
  name                = var.service_name
  location            = var.region
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = var.service_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_id
  }

  tags = {
    org          = var.organisation
    environment  = var.environment
    service_name = var.service_name
  }
}


# Create Network Security Group and rule
resource "azurerm_network_security_group" "net_sg" {
  name                = var.service_name
  location            = var.region
  resource_group_name = var.resource_group

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

  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.http_port
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTPS"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.https_port
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    org          = var.organisation
    environment  = var.environment
    service_name = var.service_name
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
    resource_group = var.resource_group
  }

  byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "storage_account" {
  name                     = "hash${random_id.machine_random_id.hex}"
  resource_group_name      = var.resource_group
  location                 = var.region
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    org          = var.organisation
    environment  = var.environment
    service_name = var.service_name
  }
}



resource "azurerm_linux_virtual_machine" "the_machine" {
  resource_group_name             = var.resource_group
  name                            = var.service_name
  location                        = var.region
  disable_password_authentication = true
  network_interface_ids           = [azurerm_network_interface.net_nic.id]
  size                            = var.size
  computer_name                   = var.service_name
  admin_username                  = var.admin_username
  custom_data                     = var.custom_data_file_path

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 120
  }

  source_image_reference {
    publisher = var.os_publisher
    offer     = var.os_offer
    sku       = var.os_sku
    version   = var.os_version
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.public_key_openssh
  }

  tags = {
    org          = var.organisation
    environment  = var.environment
    service_name = var.service_name
  }

}