variable "catalogue_name" {
  description = "The catalogue name"
  type        = string
}

variable "project_id" {
  description = "A list of projects ids"
  type        = string
}

variable "template_name" {
  description = "Helm template name"
  type = string
}

variable "namespace" {
  description = "Namespace"
  type = string
}