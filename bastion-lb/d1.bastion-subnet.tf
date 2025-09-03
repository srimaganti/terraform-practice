variable "bastion_subnet_name" {
  description = "the name of the bastion subnet"
  type = string
  default = "AzureBastionSubnet"
}
variable "bastion_subnet_address" {
  type = list(string)
  default = [ "10.0.101.0/27" ]
}