output "azure_linux_vm_ip" {
  description = "linux virtual machine ip"
    value       = azurerm_public_ip.web_vm_public_ip.ip_address
}

output "azurerm_resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name
  
}