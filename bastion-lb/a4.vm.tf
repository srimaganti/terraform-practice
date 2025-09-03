resource "azurerm_linux_virtual_machine" "linuxvm" {
  for_each = var.dasauto
  #inside this varaibel how mank key two 
  name = "${local.resource_name_prefix}-vm-${each.key}"
  #this vnet need to be part of your rg name and location 
  location            = azurerm_resource_group.rg.location #refrence
  resource_group_name = azurerm_resource_group.rg.name     #it is going to read fro
  size                = "Standard_F2"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.webvm_nic[each.key].id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pem.pub")

  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  custom_data = filebase64("${path.module}/app/app.sh")
}