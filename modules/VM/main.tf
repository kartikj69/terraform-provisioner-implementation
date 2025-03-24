resource "azurerm_linux_virtual_machine" "VM" {

  name                  = var.VM.name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.VM.size
  admin_username        = var.VM.admin_username
  admin_password        = var.VM.admin_password
  network_interface_ids = var.network_interface_ids
  disable_password_authentication = false

  os_disk {
    caching              = var.VM.caching
    storage_account_type = var.VM.storage_account_type
  }

  source_image_reference {
    publisher = var.VM.publisher
    offer     = var.VM.offer
    sku       = var.VM.sku
    version   = var.VM.version
  }
  connection {
    type = "ssh"
    host = self.public_ip_address
    user = self.admin_username
    password = self.admin_password
  }
  provisioner "file" {
    # copy index.html to the VM
    source      = "C:/Users/KartikJindal/Desktop/code/Terraform/provisioner/modules/VM/index.html"
    destination = "/home/azureuser/index.html"
  }
  provisioner "remote-exec" {
    inline = [ 
    "sudo apt-get update",
    "sudo apt-get install -y nginx",
    # Create a sample welcome page
    "sudo tee /home/azureuser/index.html <<EOF",
    "sudo systemctl start nginx",
    "sudo systemctl enable nginx",
    ]
  }
}
