#i want to create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "${local.resource_name_prefix}-${var.resource_group_name}"
  #dev-sap-rg-gopal
  location = var.resource_group_location
  tags = local.project_tag
}

