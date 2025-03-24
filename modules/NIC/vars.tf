
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location where the resources will be deployed"
  type        = string
}

variable "NIC" {
  description = "Configuration for the NIC"
  type = object({
    NIC_name                      = string
    ip_conf_name                  = string
    private_ip_address_allocation = string
  })
}
variable "subnet_id" {
  description = "value of subnet id"
  type        = string
}
variable "public_ip_id" {
  type = string
}
