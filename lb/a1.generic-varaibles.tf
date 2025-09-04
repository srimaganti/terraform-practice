variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "rg-srikanth"
}

variable "resource_group_location" {
    description = "The location of the resource group"
    type        = string #boolean, list, map
    default     = "eastus"
}

variable "environment" {
  description = "The environment for the resources"
  type        = string
  default     = "dev"
  
}

variable "business_devision" {
  description = "The business division for the resources"
  type        = string
  default     = "sap"
 
}