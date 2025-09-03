resource "azurerm_network_interface" "jump_nic" {
  name                = "${local.resource_name_prefix}-jumpnic"
  location            = azurerm_resource_group.rg.location #refrence
  resource_group_name = azurerm_resource_group.rg.name     #it is going to read fro
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web_subnet.id
    private_ip_address_allocation = "Dynamic" #the subnet will allocate an private ip public_ip_address_id = "name = "name = "name = """""
    public_ip_address_id          = azurerm_public_ip.jump_publicip.id
  }
}