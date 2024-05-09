terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 3.0.2"
    }
    random = {
        source = "hashicorp/random"
        version = ">= 3.5.0, < 4.0.0"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
    features {
      
    }
}

resource "random_string" "random" {
    length = 5
    special = false
    upper = false  
}

resource "azurerm_resource_group" "rg" {

  name = "${local.resourcegroupname}${random_string.random.result}"
  location = local.location
}

resource "azurerm_virtual_network" "virtualnetwork" {
  count = local.vnet_count
  name = "${local.virtualnetwork}-${random_string.random.result}-${count.index+1}"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  address_space = [ "10.0.0.0/24" ]
  depends_on = [ azurerm_resource_group.rg ]

}