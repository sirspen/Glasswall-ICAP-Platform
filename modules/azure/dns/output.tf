output "dns_record_set" {
  value = azurerm_dns_a_record.dns_record.records
}