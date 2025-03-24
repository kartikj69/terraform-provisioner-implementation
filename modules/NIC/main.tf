resource "azurerm_network_interface" "NIC" {
  name                = var.NIC.NIC_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.NIC.ip_conf_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.NIC.private_ip_address_allocation
    public_ip_address_id          = var.public_ip_id
  }
}