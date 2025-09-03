resource "azurerm_network_interface" "webvm_nic" {
  for_each = var.dasauto #to use the map variable and loop through it we will use var.nameof the variable
  name     = "${local.resource_name_prefix}-${each.key}"
  #this vnet need to be part of your rg name and location 
  location            = azurerm_resource_group.rg.location #refrence
  resource_group_name = azurerm_resource_group.rg.name     #it is going to read fro
  #in the nic card we are configuring the public and private ip 
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web_subnet.id
    private_ip_address_allocation = "Dynamic" #the subnet will allocate an private ip public_ip_address_id = "name = "name = "name = """""
    # public_ip_address_id          = azurerm_public_ip.web_vm_public_ip.id
  }
}