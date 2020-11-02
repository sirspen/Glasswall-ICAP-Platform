
# Common variables

variable "organisation" {
  description = "Metadata Organisation"
  type        = string
}

variable "environment" {
  description = "Metadata Environment"
  type        = string
}

variable "project" {
  description = "Metadata Project"
  type        = string
}

variable "suffix" {
  description = "Metadata Project Suffix (so that we can create multiple instances)"
  type        = string
}

variable "azure_region" {
  description = "Set the Azure Region"
  type        = string
}

variable "custom_data_file_path" {
  description = "Bootstrap the virtual machine with this file"
  type        = string
}

variable "custom_git_server_data_file_path" {
  description = "Bootstrap the gitserver virtual machine with this file"
  type        = string
}