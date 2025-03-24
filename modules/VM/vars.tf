variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location where the resources will be deployed"
  type        = string
}
variable "network_interface_ids" {
  description = "List of network interface IDs"
  type        = list(string)
  
}
variable "VM" {
  description = "Virtual Machine configuration"
  type = object({
    name                  = string
    size                  = string
    admin_username        = string
    admin_password        = string
    caching               = string
    storage_account_type  = string
    publisher             = string
    offer                 = string
    sku                   = string
    version               = string
  })
}