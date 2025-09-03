resource "azurerm_public_ip" "jump_publicip" {
  name = "${local.resource_name_prefix}-jump-public-ip"
  #this vnet need to be part of your rg name and location 
  location            = azurerm_resource_group.rg.location #refrence
  resource_group_name = azurerm_resource_group.rg.name     #it is going to read fro
  allocation_method   = "Static"
  sku                 = "Standard" #basic #premium
  tags                = local.project_tag
}