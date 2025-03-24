# Azure Terraform Provisioners: VM Provisioning with Multi-Stage Provisioners

## Overview
This project demonstrates the provisioning of an Azure Virtual Machine (VM) using Terraform, with a focus on implementing all provisioner types for initialization, configuration, and logging.

## Objective
The goal is to provision an Azure VM along with its associated resources and execute a series of provisioner operations to automate initialization, configuration, and deployment tasks.

## Resources Created
The following Azure resources will be created:
- **Resource Group**
- **Virtual Network** with a Subnet
- **Network Security Group** with inbound rules for SSH (22) and HTTP (80)
- **Public IP Address**
- **Network Interface Card**
- **Linux Virtual Machine**

## Provisioner Workflow
The provisioning process includes the following steps:

### 1. **Before VM Creation** 📝
A `local-exec` provisioner is used to create a log file with the initialization timestamp.

#### Example:
```hcl
# For Unix/Linux/MacOS systems
provisioner "local-exec" {
  command = "echo 'Initialization started at: ${timestamp()}' > deployment.log"
}

# For Windows systems
provisioner "local-exec" {
  interpreter = ["PowerShell", "-Command"]
  command     = "Write-Output 'Initialization started at: ${timestamp()}' | Out-File -FilePath deployment.log"
}
```

### 2. **After VM Creation** 🚀
A `remote-exec` provisioner is used to install and start NGINX on the VM.

#### Example:
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

### 3. **File Deployment** 📂
A `file` provisioner is used to copy a code file from the local machine to the VM's home directory.

#### Example:
```hcl
provisioner "file" {
  source      = "path/to/local/code/file"
  destination = "/home/azureuser/code-file"
}
```

### 4. **Completion Logging** ✅
A `local-exec` provisioner is used to append the deployment completion timestamp to the log file.

#### Example:
```hcl
# For Unix/Linux/MacOS systems
provisioner "local-exec" {
  command = "echo 'Deployment completed at: ${timestamp()}' >> deployment.log"
}

# For Windows systems
provisioner "local-exec" {
  interpreter = ["PowerShell", "-Command"]
  command     = "Write-Output 'Deployment completed at: ${timestamp()}' | Out-File -FilePath deployment.log -Append"
}
```

## Success Criteria
- The VM is accessible via SSH.
- NGINX is running and accessible on port 80.
- The code file is present in the VM's home directory.
- The local log file contains both initialization and completion timestamps.

## Example Connection Block
To enable SSH access for the `remote-exec` and `file` provisioners, use the following connection block:

```hcl
connection {
  type        = "ssh"
  user        = "azureuser"
  private_key = file("~/.ssh/id_rsa") (or use password)
  host        = azurerm_public_ip.example.ip_address (use self.ip_address if you are using the provisioner inside the target resource block)
}
```

## Notes
- Use the `depends_on` attribute to handle dependencies between resources.
- Ensure proper error handling for provisioners to avoid deployment failures.
- Test the provisioners in a controlled environment before deploying to production.

## Getting Started
1. Clone this repository.
2. Update the Terraform configuration files with your Azure credentials and resource details.
3. open the terminal inside the worload folder
4. Run `terraform init` to initialize the working directory.
5. Run `terraform apply` to provision the resources and execute the provisioners.

## Cleanup
To destroy the resources created by this project, run:
**Remove the lifecycle block from the resource group if you want the full cleanup**
```bash
terraform destroy
```