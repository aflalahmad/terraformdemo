locals {
  name = "myRG"
  location = "centralindia"
  vnet_name = ["vnet1","vnet2","vnet3"]
  vnet_address_prefixe = ["10.0.0.0/16","10.0.1.0/16","10.0.2.0/16"]
  vnets =zipmap(local.vnet_name,local.vnet_address_prefixe)
}