resource "azurerm_public_ip" "example" {
  name                = var.public_ip_config.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.public_ip_config.allocation_method
  sku                 = var.public_ip_config.sku
}