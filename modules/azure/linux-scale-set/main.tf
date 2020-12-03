# Create Network Security Group and rule

module "security_group" {
  source               = "../security-group"
  service_name         = "${var.service_name}-vmss"
  azure_region         = var.region
  resource_group_name  = var.resource_group
  security_group_rules = var.security_group_rules
}

resource "azurerm_linux_virtual_machine_scale_set" "cluster_scaleset_lb" {
  count                           = var.loadbalancer? 1 : 0 
  name                            = var.service_name
  location                        = var.region
  resource_group_name             = var.resource_group
  sku                             = var.size
  instances                       = var.sku_capacity
  admin_username                  = var.admin_username
  # automatic rolling upgrade
  #automatic_os_upgrade            = false
  #upgrade_policy_mode             = "Manual"
  single_placement_group          = false
  disable_password_authentication = true
  health_probe_id                 = var.lb_probe_id

  # required when using rolling upgrade policy

  source_image_reference {
    publisher = var.os_publisher
    offer     = var.os_offer
    sku       = var.os_sku
    version   = var.os_version
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
    disk_size_gb         = 60
  }

  data_disk {
    lun                   = 0
    caching               = "ReadWrite"
    create_option         = "Empty"
    disk_size_gb          = 120
    storage_account_type  = "Standard_LRS"
  }

  admin_ssh_key {
    username             = var.admin_username
    public_key           = var.public_key_openssh
  }

  network_interface {
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

  tags = {
    "cluster-autoscaler" = var.tag_cluster_asg_state
    "cluster" = var.tag_cluster_name
    "roles" = var.service_role
  }
}

resource "azurerm_linux_virtual_machine_scale_set" "cluster_scaleset_nolb" {
  count               = var.loadbalancer? 0 : 1 
   name                            = var.service_name
  location                        = var.region
  resource_group_name             = var.resource_group
  sku                             = var.size
  instances                       = var.sku_capacity
  admin_username                  = var.admin_username
  # automatic rolling upgrade
  #automatic_os_upgrade            = false
  #upgrade_policy_mode             = "Manual"
  single_placement_group          = false
  disable_password_authentication = true
  health_probe_id                 = var.lb_probe_id

  # required when using rolling upgrade policy

  source_image_reference {
    publisher = var.os_publisher
    offer     = var.os_offer
    sku       = var.os_sku
    version   = var.os_version
  }
  
  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
    disk_size_gb         = 60
  }

  data_disk {
    lun                   = 0
    caching               = "ReadWrite"
    create_option         = "Empty"
    disk_size_gb          = 120
    storage_account_type  = "Standard_LRS"
  }

  admin_ssh_key {
    username             = var.admin_username
    public_key           = var.public_key_openssh
  }

  network_interface {    
    name    = "${var.service_name}-net-profile"
    primary = true

    ip_configuration {
      name                                   = "${var.service_name}-ip-config"
      primary                                = true
      subnet_id                              =  var.subnet_id
    }

    network_security_group_id              = module.security_group.id
  }

  tags = {
    "cluster-autoscaler" = var.tag_cluster_asg_state
    "cluster" = var.tag_cluster_name
    "roles" = var.service_role
  }
}