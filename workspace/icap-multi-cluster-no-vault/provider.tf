provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=2.30.0"
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

provider "rancher2" {
  api_url   = local.rancher_api_url
  token_key = local.rancher_admin_token
  insecure  = true
}