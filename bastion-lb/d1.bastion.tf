resource "azurerm_subnet" "bastion_service_subnet" {
  name                 = var.bastion_subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.bastion_subnet_address
}
resource "azurerm_public_ip" "bastion_publicip" {
  name = "${local.resource_name_prefix}-bastion-publicip"
  #this vnet need to be part of your rg name and location 
  location            = azurerm_resource_group.rg.location #refrence
  resource_group_name = azurerm_resource_group.rg.name     #it is going to read fro
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.project_tag
}

resource "azurerm_bastion_host" "bastion_host" {
  name = "${local.resource_name_prefix}-bastion-host"
  #this vnet need to be part of your rg name and location 
  location            = azurerm_resource_group.rg.location #refrence
  resource_group_name = azurerm_resource_group.rg.name   
  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion_service_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_publicip.id
  }
}