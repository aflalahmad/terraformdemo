terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 3.0.2"
    }
  }
  required_version = ">=1.1.0"
}
provider "azurerm" {
    features {
      
    }
  
}

resource "azurerm_resource_group" "rg" {
    name = "Afl"
    location = "centralindia"
  
}

resource "azurerm_virtual_network" "vnets" {

    for_each = var.virtualnetworks

    name = each.key
    address_space = [ each.value.address_space ]
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location

    dynamic "subnet" {
        for_each = each.value.subnets

        content {
          name = subnet.key
          address_prefix = subnet.value.address_prefix
        }
      
    }
    
  
}