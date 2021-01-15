# Create Network Security Group and rule

module "security_group" {
  source               = "../security-group"
  service_name         = "${var.service_name}-vmss"
  azure_region         = var.region
  resource_group_name  = var.resource_group
  security_group_rules = var.security_group_rules
}

resource "azurerm_virtual_machine_scale_set" "cluster_scaleset_lb" {
  count               = var.loadbalancer? 1 : 0 
  name                = var.service_name
  location            = var.region
  resource_group_name = var.resource_group

  # automatic rolling upgrade
  automatic_os_upgrade  = false
  upgrade_policy_mode   = "Manual"
  single_placement_group= false
  #rolling_upgrade_policy {
  #  max_batch_instance_percent              = 20
  #  max_unhealthy_instance_percent          = 20
  #  max_unhealthy_upgraded_instance_percent = 5
  #  pause_time_between_batches              = "PT0S"
  #}

    health_probe_id = var.lb_probe_id

  # required when using rolling upgrade policy

  sku {
    name     = var.size
    tier     = "Standard"
    capacity = var.sku_capacity
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
    lun               = 0
    caching           = "ReadWrite"
    create_option     = "Empty"
    disk_size_gb      = 120
  }

  os_profile {
    computer_name_prefix = var.service_name
    admin_username       = var.admin_username
    custom_data          = var.custom_data
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
      key_data = var.public_key_openssh
    }
  }

  network_profile {
    name    = "${var.service_name}-net-profile"
    primary = true

    ip_configuration {
      name                                   = "${var.service_name}-ip-config"
      primary                                = true
      subnet_id                              =  var.subnet_id
      load_balancer_backend_address_pool_ids = var.lb_backend_address_pool_id
    }
      network_security_group_id              = module.security_group.id
  }

  tags = var.tags
}

resource "azurerm_virtual_machine_scale_set" "cluster_scaleset_nolb" {
  count               = var.loadbalancer? 0 : 1 
  name                = var.service_name
  location            = var.region
  resource_group_name = var.resource_group

  # automatic rolling upgrade
  automatic_os_upgrade  = false
  upgrade_policy_mode   = "Manual"
  single_placement_group= false
  #rolling_upgrade_policy {
  #  max_batch_instance_percent              = 20
  #  max_unhealthy_instance_percent          = 20
  #  max_unhealthy_upgraded_instance_percent = 5
  #  pause_time_between_batches              = "PT0S"
  #}

  # required when using rolling upgrade policy

  sku {
    name     = var.size
    tier     = "Standard"
    capacity = var.sku_capacity
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
    lun               = 0
    caching           = "ReadWrite"
    create_option     = "Empty"
    disk_size_gb      = 120
  }

  os_profile {
    computer_name_prefix = var.service_name
    admin_username       = var.admin_username
    custom_data          = var.custom_data
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
      key_data = var.public_key_openssh
    }
  }

  network_profile {
    name    = "${var.service_name}-net-profile"
    primary = true

    ip_configuration {
      name                                   = "${var.service_name}-ip-config"
      primary                                = true
      subnet_id                              = var.subnet_id      
    }

    network_security_group_id                = module.security_group.id

  }

  tags = {
    "cluster-autoscaler" = var.tag_cluster_asg_state
    "cluster" = var.tag_cluster_name
    "roles" = var.service_role
  }
}