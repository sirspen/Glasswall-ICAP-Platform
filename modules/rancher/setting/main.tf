
resource "rancher2_setting" "main" {
  provider  = rancher2
  name      = var.setting_name
  value     = var.setting_value
}