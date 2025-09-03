
output "frontend_ip_load_balancer" {
  description = "frontend ip of lb"
  value = azurerm_public_ip.lb_publicip.ip_address
}
output "azurerm_resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name

}