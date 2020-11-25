# Rancher API Url
variable "rancher_admin_url" {
  description = "The Rancher API"
  type        = string
}

#Rancher API Admin Token
variable "rancher_admin_token" {
  description = "The Rancher Admin Token"
  type        = string
}

variable "catalogue_name" {
  description = "The catalogue name"
  type        = string
}

variable "project_ids" {
  description = "A list of projects ids"
  type        = set(string)
}

variable "template_name" {
  description = "Helm template name"
  type = string
}

variable "namespace" {
  description = "Namespace"
  type = string
}