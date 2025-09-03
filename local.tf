locals {
  owner       = var.business_devision
  environment = var.environment
  resource_name_prefix = "${var.environment}-${var.business_devision}"
  #dev-sap
  project_tag = { #this is a name
    owner = local.owner
    environment = local.environment
    terraform = "projectx"
  }
}