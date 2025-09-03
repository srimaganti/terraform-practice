resource "null_resource" "copy_ssh_key" {
  depends_on = [azurerm_linux_virtual_machine.jump_linuxvm]
  connection {
    type        = "ssh" #RDP
    host        = azurerm_linux_virtual_machine.jump_linuxvm.public_ip_address
    user        = azurerm_linux_virtual_machine.jump_linuxvm.admin_username
    private_key = file("${path.module}/ssh-keys/terraform-azure.pem")
  }
  provisioner "file" {
    source      = "ssh-keys/terraform-azure.pem" #local machine
    destination = "/tmp/terraform-azure.pem"     #inside your vm 
  }
  provisioner "remote-exec" {
    inline = [
      "chmod 400 /tmp/terraform-azure.pem"
    ]
  }
}