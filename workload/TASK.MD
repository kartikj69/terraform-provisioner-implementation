# Azure Terraform Task: VM Provisioning with Multi-Stage Provisioners

## Objective
Provision an Azure Virtual Machine with associated resources, implementing multiple provisioner types for initialization, configuration, and logging.

## Requirements

### Resources to Create
- Resource Group
- Virtual Network with Subnet
- Network Security Group with inbound rules for SSH (22) and HTTP (80)
- Public IP Address
- Network Interface Card
- Linux Virtual Machine

### Provisioner Implementation
The following provisioner operations must be implemented in sequence:

1. **Before VM Creation** 📝
    - Use a `local-exec` provisioner to create a log file with initialization timestamp
    ```hcl
    # For Unix/Linux/MacOS systems
    provisioner "local-exec" {
      command = "echo 'Initialization started at: $(date)' > deployment.log"
    }

    # For Windows systems
    provisioner "local-exec" {
      interpreter = ["PowerShell", "-Command"]
      command     = "Write-Output 'Initialization started at: $(Get-Date)' | Out-File -FilePath deployment.log"
    }
    ```

2. **After VM Creation** 🚀
    - Use a `remote-exec` provisioner to install and start NGINX
    ```hcl
    provisioner "remote-exec" {
      inline = [
         "sudo apt-get update",
         "sudo apt-get install -y nginx",
         "sudo systemctl start nginx",
         "sudo systemctl enable nginx"
      ]
    }
    ```

3. **File Deployment** 📂
    - Use a `file` provisioner to copy a code file to the VM's home directory
    ```hcl
    provisioner "file" {
      source      = "path/to/local/code/file"
      destination = "/home/azureuser/code-file"
    }
    ```

4. **Completion Logging** ✅
    - Use another `local-exec` provisioner to append the completion timestamp to the log file
    ```hcl
    # For Unix/Linux/MacOS systems
    provisioner "local-exec" {
      command = "echo 'Deployment completed at: $(date)' >> deployment.log"
    }

    # For Windows systems
    provisioner "local-exec" {
      interpreter = ["PowerShell", "-Command"]
      command     = "Write-Output 'Deployment completed at: $(Get-Date)' | Out-File -FilePath deployment.log -Append"
    }
    ```

## Success Criteria
- The VM should be accessible via SSH
- NGINX should be running and accessible on port 80
- The code file should be present in the home directory
- The local log file should contain both start and completion timestamps

## Notes
- Ensure proper connection blocks for SSH access
- Remember to handle dependencies correctly using the `depends_on` attribute
- Include proper error handling for provisioners

## Example Connection Block
```hcl
connection {
  type        = "ssh"
  user        = "azureuser"
  private_key = file("~/.ssh/id_rsa")
  host        = azurerm_public_ip.example.ip_address
}
```