resource "azurerm_network_security_rule" "main" {
    for_each                    = var.security_group_rules
    resource_group_name         = var.resource_group_name
    network_security_group_name = var.network_security_group_name
    name                        = each.key
    direction                   = each.value.direction
    access                      = each.value.access
    priority                    = each.value.priority
    protocol                    = each.value.protocol
    source_port_range           = each.value.source_port_range
    destination_port_range      = each.value.destination_port_range
    source_address_prefix       = each.value.source_address_prefix
    destination_address_prefix  = each.value.destination_address_prefix
}