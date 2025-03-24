resource "azurerm_network_security_group" "nsg" {
  name                = var.NSG_name
  location            = var.location
  resource_group_name = var.resource_group_name
  security_rule {
    name                       = var.security_rule.name
    priority                   = var.security_rule.priority
    direction                  = var.security_rule.direction
    access                     = var.security_rule.access
    protocol                   = var.security_rule.protocol
    source_port_range          = var.security_rule.source_port_range
    destination_port_range     = var.security_rule.destination_port_range
    source_address_prefix      = var.security_rule.source_address_prefix
    destination_address_prefix = var.security_rule.destination_address_prefix
  }
  security_rule {
    name                       = var.security_rule2.name
    priority                   = var.security_rule2.priority
    direction                  = var.security_rule2.direction
    access                     = var.security_rule2.access
    protocol                   = var.security_rule2.protocol
    source_port_range          = var.security_rule2.source_port_range
    destination_port_range     = var.security_rule2.destination_port_range
    source_address_prefix      = var.security_rule2.source_address_prefix
    destination_address_prefix = var.security_rule2.destination_address_prefix
  }
}