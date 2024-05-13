terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 3.0.2"
    }
  }
  required_version = ">= 1.1.0"
}
provider "azurerm" {
    features {
      
    }
  
}

variable "vnetname" {
    type = list(string)
    default = ["vnet1","vnet2","vnet3"]
  
}
variable "address_space" {
    type = list(string)
    default = [ "10.0.0.0/16", "10.2.0.0/16", "10.1.0.0/16" ]  
}

locals {
  name = "demorg"
  location = "westus"
  mymaps = zipmap(var.vnetname,var.address_space)
}

resource "azurerm_resource_group" "rg" {

    name = local.name
    location = local.location
  
}

resource "azurerm_virtual_network" "vnet" {
    for_each = local.mymaps

    name = each.key
    address_space = [ each.value ]
    location = local.location
    resource_group_name = local.name
    depends_on = [ azurerm_resource_group.rg ]
  
}