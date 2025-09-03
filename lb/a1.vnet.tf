resource "azurerm_virtual_network" "vnet" {
  name = "${local.resource_name_prefix}-${var.vnet_name}"
  #this vnet need to be part of your rg name and location 
  location            = azurerm_resource_group.rg.location #refrence
  resource_group_name = azurerm_resource_group.rg.name     #it is going to read from state file 
  address_space       = var.vnet_address_space
  tags                = local.project_tag
}