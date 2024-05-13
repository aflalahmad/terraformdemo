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

variable "vnet" {
    type = list(string)
    default = [ "vnet1","vnet2","vnet3" ]
  
}
variable "vnet_address_space" {
     type = list(string)
     default = [ "10.0.0.0/16", "10.1.0.0/16", "10..0.0/16" ]
}
variable "location" {
    type = string
    default =  "eastus"
  
}
variable "resource_group" {
    type = string
    default = "newrg"
  
}

resource "azurerm_resource_group" "rg" {
    name = var.resource_group
    location = var.location
  
}

resource "azurerm_virtual_network" "vnt" {
    count = length(var.vnet)
    name = var.vnet[count.index]
    address_space = [var.vnet_address_space[count.index]]
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
  
}