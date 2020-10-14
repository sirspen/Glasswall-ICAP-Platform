
# Common variables

variable "cluster_network_plugin" {
  description = "Set the network plugin"
  type        = string
}

variable "cluster_name" {
  description = "Bootstrap the virtual machine with this file"
  type        = string
}

variable "kubernetes_version" {
  description = "The Kubernetes version"
  type        = string
  default     = "1.18.9"
}