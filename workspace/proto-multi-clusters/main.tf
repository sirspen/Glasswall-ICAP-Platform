
locals {
  short_region_r1          = substr(var.azure_region_r1, 0, 3)
  short_region_r2          = substr(var.azure_region_r2, 0, 3)
  service_name             = "${var.organisation}-${var.project}-${var.environment}"
  admin_service_name       = "${var.organisation}-${var.project}-admin-${var.environment}"
  service_name_nodash_r1   = "${var.organisation}icap${var.environment}${local.short_region_r1}"
  service_name_nodash_r2   = "${var.organisation}icap${var.environment}${local.short_region_r2}"
  
  cluster_catalogs = {
    icap-catalog = {
      helm_charts_repo_url    = "${var.git_server_url}/icap-infrastructure.git"
      helm_charts_repo_branch = "add-image-registry"
    }
  }
  azure_icap_clusters = {
    northeurope = {
      suffix                       = var.icap_cluster_suffix_r1
      cluster_quantity             = var.icap_cluster_quantity
      azure_region                 = var.azure_region_r1
      fault_domain_count           = var.fault_domain_count_r1
      cluster_backend_port         = var.icap_backend_port
      cluster_public_port          = var.icap_public_port
      cluster_address_space        = var.icap_cluster_address_space_r1
      cluster_subnet_cidr          = var.icap_cluster_subnet_cidr_r1
      cluster_subnet_prefix        = var.icap_cluster_subnet_prefix_r1
      os_publisher                 = var.os_publisher
      os_offer                     = var.os_offer
      os_sku                       = var.os_sku
      os_version                   = var.os_version
      master_scaleset_size         = "Standard_DS4_v2"
      master_scaleset_admin_user   = "azure-user"
      master_scaleset_sku_capacity = var.icap_master_scaleset_sku_capacity
      worker_scaleset_size         = "Standard_DS4_v2"
      worker_scaleset_admin_user   = "azure-user"
      worker_scaleset_sku_capacity = var.icap_worker_scaleset_sku_capacity
      rancher_projects             = "icapservice"
      icap_internal_services       = var.icap_internal_services
    },
    ukwest = {
      suffix                       = var.icap_cluster_suffix_r2
      cluster_quantity             = var.icap_cluster_quantity
      azure_region                 = var.azure_region_r2
      fault_domain_count           = var.fault_domain_count_r2
      cluster_backend_port         = var.icap_backend_port
      cluster_public_port          = var.icap_public_port
      cluster_address_space        = var.icap_cluster_address_space_r2
      cluster_subnet_cidr          = var.icap_cluster_subnet_cidr_r2
      cluster_subnet_prefix        = var.icap_cluster_subnet_prefix_r2
      os_publisher                 = var.os_publisher
      os_offer                     = var.os_offer
      os_sku                       = var.os_sku
      os_version                   = var.os_version
      master_scaleset_size         = "Standard_DS4_v2"
      master_scaleset_admin_user   = "azure-user"
      master_scaleset_sku_capacity = var.icap_master_scaleset_sku_capacity
      worker_scaleset_size         = "Standard_DS4_v2"
      worker_scaleset_admin_user   = "azure-user"
      worker_scaleset_sku_capacity = var.icap_worker_scaleset_sku_capacity
      rancher_projects             = "icapservice"
      icap_internal_services       = var.icap_internal_services
    },
    uksouth = {
      suffix                       = var.icap_cluster_suffix_r3
      cluster_quantity             = var.icap_cluster_quantity
      azure_region                 = var.azure_region_r3
      fault_domain_count           = var.fault_domain_count_r3
      cluster_backend_port         = var.icap_backend_port
      cluster_public_port          = var.icap_public_port
      cluster_address_space        = var.icap_cluster_address_space_r3
      cluster_subnet_cidr          = var.icap_cluster_subnet_cidr_r3
      cluster_subnet_prefix        = var.icap_cluster_subnet_prefix_r3
      os_publisher                 = var.os_publisher
      os_offer                     = var.os_offer
      os_sku                       = var.os_sku
      os_version                   = var.os_version
      master_scaleset_size         = "Standard_DS4_v2"
      master_scaleset_admin_user   = "azure-user"
      master_scaleset_sku_capacity = var.icap_master_scaleset_sku_capacity
      worker_scaleset_size         = "Standard_DS4_v2"
      worker_scaleset_admin_user   = "azure-user"
      worker_scaleset_sku_capacity = var.icap_worker_scaleset_sku_capacity
      rancher_projects             = "icapservice"
      icap_internal_services       = var.icap_internal_services
    }
  }
}

data "azurerm_key_vault" "key_vault" {
  name                = var.azure_keyvault_name
  resource_group_name = var.azure_keyvault_resource_group
}

data "azurerm_key_vault_secret" "az-client-id" {
  name         = "icap-service-principle-id"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "az-client-secret" {
  name         = "icap-service-principle-value"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "az-subscription-id" {
  name         = "az-subscription-id"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "docker-config-json" {
  name         = "az-registry-dockerconfig"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

module "setting" {
  source            = "../../modules/rancher/setting"
  setting_name      = "server-url"
  setting_value     = var.rancher_api_url
}

# module.setting reboots the rancher server (it also recycles the certs) which might be 
# causing issues with the catalog deployment right below.
resource "time_sleep" "wait_60_for_rancher_setting" {
  depends_on      = [module.setting]
  create_duration = "60s"
}

module "catalog" {
  source                  = "../../modules/rancher/catalogue"
  for_each                = local.cluster_catalogs
  name                    = each.key
  helm_charts_repo_url    = each.value.helm_charts_repo_url
  helm_charts_repo_branch = each.value.helm_charts_repo_branch
}

module "icap_clusters" {
  source                       = "../../modules/gw/cluster"
  for_each                     = local.azure_icap_clusters
  cluster_quantity             = each.value.cluster_quantity
  suffix                       = each.value.suffix
  azure_region                 = each.value.azure_region
  fault_domain_count           = each.value.fault_domain_count
  rancher_projects             = each.value.rancher_projects
  cluster_backend_port         = each.value.cluster_backend_port
  cluster_public_port          = each.value.cluster_public_port
  cluster_address_space        = each.value.cluster_address_space
  cluster_subnet_cidr          = each.value.cluster_subnet_cidr
  cluster_subnet_prefix        = each.value.cluster_subnet_prefix
  cluster_internal_services    = each.value.icap_internal_services
  os_publisher                 = each.value.os_publisher
  os_offer                     = each.value.os_offer
  os_sku                       = each.value.os_sku
  os_version                   = each.value.os_version
  master_scaleset_size         = each.value.master_scaleset_size
  master_scaleset_admin_user   = each.value.master_scaleset_admin_user
  master_scaleset_sku_capacity = each.value.master_scaleset_sku_capacity
  worker_scaleset_size         = each.value.worker_scaleset_size
  worker_scaleset_admin_user   = each.value.worker_scaleset_admin_user
  worker_scaleset_sku_capacity = each.value.worker_scaleset_sku_capacity
  security_group_rules         = {
    icap = {
      name                       = "icapNodePort"
      priority                   = 1004
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = var.icap_backend_port
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    policy = {
      name                       = "icapPolicyNodePort"
      priority                   = 1005
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = var.policy_update_backend_port
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    transaction = {
      name                       = "icapTransactionNodePort"
      priority                   = 1006
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = var.transaction_update_backend_port
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    ncfs = {
      name                       = "icapNcfsNodePort"
      priority                   = 1007
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = var.ncfs_update_backend_port
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
  organisation                 = var.organisation
  environment                  = var.environment
  dns_zone                     = var.dns_zone
  cluster_stage1_apps          = var.icap_cluster_stage1_apps
  rancher_admin_url            = var.rancher_api_url
  rancher_internal_api_url     = var.rancher_internal_api_url
  rancher_server_name          = var.rancher_server_name
  rancher_internal_ip          = var.rancher_internal_ip
  rancher_admin_token          = var.rancher_admin_token
  rancher_network              = var.rancher_network
  rancher_resource_group       = var.rancher_resource_group
  rancher_agent_version        = var.rancher_agent_version
  service_name                 = local.service_name
  client_id                    = data.azurerm_key_vault_secret.az-client-id.value
  client_secret                = data.azurerm_key_vault_secret.az-client-secret.value
  subscription_id              = data.azurerm_key_vault_secret.az-subscription-id.value
  tenant_id                    = var.tenant_id
  public_key_openssh           = var.public_key_openssh
  rancher_network_id           = var.rancher_network_id
  helm_chart_repo_url          = "${var.git_server_url}/icap-infrastructure.git"
  docker_config_json           = data.azurerm_key_vault_secret.docker-config-json.value
}

module "admin_cluster" {
  source                   = "../../modules/gw/standalone-cluster"
  depends_on = [ module.icap_clusters ]
  organisation             = var.organisation
  environment              = var.environment
  dns_zone                 = var.dns_zone
  rancher_admin_url        = var.rancher_api_url
  rancher_internal_api_url = var.rancher_internal_api_url
  rancher_internal_ip      = var.rancher_internal_ip
  rancher_server_name      = var.rancher_server_name
  rancher_admin_token      = var.rancher_admin_token
  rancher_network          = var.rancher_network
  rancher_network_id       = var.rancher_network_id
  # we may not want to always reuse the same resource_group.
  rancher_resource_group   = var.rancher_resource_group
  rancher_agent_version    = var.rancher_agent_version
  cluster_network_name     = var.rancher_network_name
  cluster_subnet_name      = var.rancher_subnet_name
  cluster_subnet_id        = var.rancher_subnet_id
  cluster_backend_port     = var.admin_cluster_backend_port
  cluster_public_port      = var.admin_cluster_public_port
  cluster_stage1_apps      = var.admin_cluster_stage1_apps
  cluster_subnet_prefix    = var.rancher_subnet_prefix
  service_name             = local.admin_service_name
  suffix                   = var.rancher_suffix
  azure_region             = var.rancher_region
  client_id                = data.azurerm_key_vault_secret.az-client-id.value
  client_secret            = data.azurerm_key_vault_secret.az-client-secret.value
  subscription_id          = data.azurerm_key_vault_secret.az-subscription-id.value
  tenant_id                = var.tenant_id
  public_key_openssh       = var.public_key_openssh
  os_publisher             = var.os_publisher
  os_offer                 = var.os_offer
  os_sku                   = var.os_sku
  os_version               = var.os_version
  rancher_projects         = "adminservice"
  security_group_rules         = {
    admin = {
      name                       = "adminNodePort"
      priority                   = 1006
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = var.admin_cluster_backend_port
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

  master_scaleset_size         = "Standard_DS4_v2"
  master_scaleset_admin_user   = "azure-user"
  master_scaleset_sku_capacity = 1
  worker_scaleset_size         = "Standard_DS4_v2"
  worker_scaleset_admin_user   = "azure-user"
  worker_scaleset_sku_capacity = 1
  helm_chart_repo_url          = "${var.git_server_url}/icap-infrastructure.git"
  docker_config_json           = data.azurerm_key_vault_secret.docker-config-json.value
  cluster_endpoints            = [
    for cluster in module.icap_clusters :
      trimsuffix(cluster.int_cluster_worker_lb_dns_name,".")
  ]
}