Vnet = {
  vnet_name               = "vnet-VM"
  vnet_address_space      = ["10.0.0.0/16"]
  subnet_name             = "vm-subnet"
  subnet_address_prefixes = ["10.0.0.0/24"]
}
public_ip_config = {
  public_ip_name    = "public-ip"
  allocation_method = "Static"
  sku               = "Standard"
}
NIC = {
  NIC_name                      = "nic-VM"
  ip_conf_name                  = "ipconf-VM"
  private_ip_address_allocation = "Dynamic"
}
security_rule = {
  name                       = "allow-ssh"
  priority                   = 1001
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "*"
  source_port_range          = "*"
  destination_port_range     = "22"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}
security_rule2 = {
  name                       = "allow-http"
  priority                   = 100
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "*"
  source_port_range          = "*"
  destination_port_range     = "80"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}
VM = {
  name                 = "VM-1"
  size                 = "Standard_B2as_v2"
  admin_username       = "azureuser"
  admin_password       = "P@ssw0rd1234"
  caching              = "ReadWrite"
  storage_account_type = "Standard_LRS"
  publisher            = "Canonical"
  offer                = "UbuntuServer"
  sku                  = "18.04-LTS"
  version              = "latest"
}