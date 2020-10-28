
resource "azurerm_virtual_machine_scale_set" "cluster_scaleset" {
  name                = var.service_name
  location            = var.region
  resource_group_name = var.resource_group

  # automatic rolling upgrade
  automatic_os_upgrade = true
  upgrade_policy_mode  = "Rolling"

  rolling_upgrade_policy {
    max_batch_instance_percent              = 20
    max_unhealthy_instance_percent          = 20
    max_unhealthy_upgraded_instance_percent = 5
    pause_time_between_batches              = "PT0S"
  }

  # required when using rolling upgrade policy
  health_probe_id = var.lb_probe_id

  sku {
    name     = var.size
    tier     = "Standard"
    capacity = 2
  }

  storage_profile_image_reference {
    publisher = var.os_publisher
    offer     = var.os_offer
    sku       = var.os_sku
    version   = var.os_version
  }

  storage_profile_os_disk {
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_profile_data_disk {
    caching       = "ReadWrite"
    create_option = "FromImage"
    disk_size_gb  = 120
  }

  os_profile {
    computer_name_prefix = var.service_name
    admin_username       = var.admin_username
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
      key_data = file(public_key_openssh)
    }
  }

  network_profile {
    name    = "${var.service_name}-net-profile"
    primary = true

    ip_configuration {
      name                                   = "${var.service_name}-ip-config"
      primary                                = true
      subnet_id                              = var.subnet_name
    }
  }

  tags = {
    environment = var.environment
  }
}