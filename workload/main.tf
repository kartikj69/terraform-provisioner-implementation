resource "azurerm_resource_group" "rg" {
  name     = "Kartik-RG"
  location = "eastus"
  lifecycle {
    prevent_destroy = true
  }
}
module "network" {
  source              = "../modules/Network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  Vnet                = var.Vnet
  depends_on          = [azurerm_resource_group.rg]
}
module "public_ip" {
  source              = "../modules/public-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  public_ip_config    = var.public_ip_config
  depends_on          = [azurerm_resource_group.rg]
}
module "NIC" {
  source              = "../modules/NIC"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  NIC                 = var.NIC
  subnet_id           = module.network.SubnetID
  public_ip_id        = module.public_ip.public_ip_id
  depends_on          = [module.network, module.public_ip]
}
module "NSG" {
  source              = "../modules/Security"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  NSG_name            = var.NSG_name
  security_rule       = var.security_rule
  depends_on          = [azurerm_resource_group.rg]
}
module "connection_nsg_nic" {
  source                    = "../modules/NIC-NSG con"
  network_interface_id      = module.NIC.Nic_id
  network_security_group_id = module.NSG.NSG_id
  depends_on                = [module.NIC, module.NSG]
}
module "VM" {
  source                = "../modules/VM"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  VM                    = var.VM
  network_interface_ids = [module.NIC.Nic_id]
  depends_on            = [module.connection_nsg_nic, null_resource.provisioner]
}
resource "null_resource" "provisioner" {
  provisioner "local-exec" {
    interpreter = ["PowerShell", "-Command"]
    command     = "Write-Output 'Initialization started at: ${timestamp()}' | Out-File -FilePath deployment.log"
  }
}
resource "null_resource" "provisioner2" {
  triggers = {
    VM_id = module.VM.VM_id
  }
  provisioner "local-exec" {
    interpreter = ["PowerShell", "-Command"]
    command     = "Write-Output 'Initialization completed at: ${timestamp()}' | Out-File -FilePath deployment.log -Append"
  }
  depends_on = [module.VM]
}