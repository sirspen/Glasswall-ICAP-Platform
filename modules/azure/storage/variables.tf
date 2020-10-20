variable "location" {
  description = "The Azure Location"
  type        = string
  default     = "UK South"
}

variable "account_tier" {
  description = "The storage account tier"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "The storage account replication type"
  type        = string
  default     = "LRS"
}