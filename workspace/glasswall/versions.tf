terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = "~> 2.30.0"
    rancher2 = {
      source = "rancher/rancher2"
      version = "1.10.3"
    }
  }
}