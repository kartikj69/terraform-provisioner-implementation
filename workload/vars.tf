variable "Vnet" {
  description = "Virtual Network configuration"
  type = object({
    vnet_name               = string
    vnet_address_space      = list(string)
    subnet_name             = string
    subnet_address_prefixes = list(string)
  })
}
variable "public_ip_config" {
  description = "Configuration for the public IP."
  type = object({
    public_ip_name    = string
    allocation_method = string
    sku               = string
  })
}
variable "NIC" {
  description = "Configuration for the NIC"
  type = object({
    NIC_name                      = string
    ip_conf_name                  = string
    private_ip_address_allocation = string
  })
  default = {
    NIC_name                      = "nic-VM"
    ip_conf_name                  = "ipconf-VM"
    subnet_id                     = "vm-subnet"
    private_ip_address_allocation = "Static"
  }
}
variable "NSG_name" {
  description = "The name of the Network Security Group"
  type        = string
  default     = "vm-nsg"
}

variable "security_rule" {
  description = "Security rule configuration"
  type = object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  })
}
variable "security_rule2" {
  description = "Security rule configuration"
  type = object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  })
}
variable "VM" {
  description = "Virtual Machine configuration"
  type = object({
    name                 = string
    size                 = string
    admin_username       = string
    admin_password       = string
    caching              = string
    storage_account_type = string
    publisher            = string
    offer                = string
    sku                  = string
    version              = string
  })
}