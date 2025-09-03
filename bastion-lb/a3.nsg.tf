resource "azurerm_network_security_group" "web_subnet_nsg" {
  name = "${local.resource_name_prefix}-nsg"
  #this vnet need to be part of your rg name and location 
  location            = azurerm_resource_group.rg.location #refrence
  resource_group_name = azurerm_resource_group.rg.name     #it is going to read fro

  tags = local.project_tag
}
#we want to attach the nsg with websubnet
resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.web_subnet.id
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id
}
#lets create nsg rule 
#open 22 80 443 8080
locals {
  Web_nsg_rule_inbound = {
    "110" : "22",
    "120" : "443",
    "130" : "80"
  }
}
resource "azurerm_network_security_rule" "Web_nsg_rule" {
  for_each                    = local.Web_nsg_rule_inbound
  name                        = "Rule-Port-${each.value}" #Rule-Port-22
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.web_subnet_nsg.name
}
