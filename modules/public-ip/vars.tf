variable "resource_group_name" {
  description = "The name of the resource group in which to create the public IP."
  type        = string
}

variable "location" {
  description = "The location/region where the public IP should be created."
  type        = string
}

variable "public_ip_config" {
  description = "Configuration for the public IP."
  type = object({
    public_ip_name    = string
    allocation_method = string
    sku               = string
  })
}
