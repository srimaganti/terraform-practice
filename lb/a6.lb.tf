#here we will create the lb and attach the frontendip
resource "azurerm_lb" "azure_lb" {
  depends_on = [azurerm_linux_virtual_machine.linuxvm]
  name       = "${local.resource_name_prefix}-lb"
  #this vnet need to be part of your rg name and location 
  location            = azurerm_resource_group.rg.location #refrence
  resource_group_name = azurerm_resource_group.rg.name     #it is going to read fro
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_publicip.id
  }
}
#we will create a backend pool
resource "azurerm_lb_backend_address_pool" "lb_backe_end_pool" {
  loadbalancer_id = azurerm_lb.azure_lb.id
  name            = "BackEndAddressPool"
}

#we will create a probe which is health check up
resource "azurerm_lb_probe" "lb_probe" {
  loadbalancer_id = azurerm_lb.azure_lb.id
  name            = "frontendprobe"
  protocol        = "Tcp"
  #protocol = "Http"
  #request_path = "/var/www/html/app/index.html"
  port                = 80 #tomcat
  interval_in_seconds = 30
  number_of_probes    = 2 #1 min it will ping your application port 
}
#we will create an lb rule
resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = azurerm_lb.azure_lb.id
  name                           = "lbrule"
  protocol                       = "Tcp"
  frontend_port                  = 80 #lb port
  backend_port                   = 80 #application port
  frontend_ip_configuration_name = azurerm_lb.azure_lb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_backe_end_pool.id]
  probe_id                       = azurerm_lb_probe.lb_probe.id
}

#we will attach both the nic card with backend pool
resource "azurerm_network_interface_backend_address_pool_association" "nic_association" {
  for_each                = var.dasauto
  network_interface_id    = azurerm_network_interface.webvm_nic[each.key].id
  ip_configuration_name   = azurerm_network_interface.webvm_nic[each.key].ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backe_end_pool.id

}