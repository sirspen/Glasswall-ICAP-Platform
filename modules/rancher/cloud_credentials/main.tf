

resource "rancher2_cloud_credential" "credentials"{
  name = var.credential_name
  azure_credential_config{
    client_id = var.client_id
    client_secret = var.client_secret
    subscription_id = var.subscription_id
  }
}