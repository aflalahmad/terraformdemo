terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
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

  for_each = var.rg

  name     = each.value.name
  location = each.value.location

}

resource "azurerm_virtual_network" "virtualnetwork" {
  for_each = var.vnets

  name = each.key
  address_space = [ each.value.address_prefix ]
  location = each.value.location
  resource_group_name = each.value.resource_group
  depends_on = [ azurerm_resource_group.rg ]
}

resource "azurerm_subnet" "subnet" {
    for_each = var.vnets

    name = "${each.key}-subnet"
    address_prefixes = [each.value.subnet_address_prefix]
    resource_group_name = each.value.resource_group
    virtual_network_name = azurerm_virtual_network.virtualnetwork[each.key].name
  
}

# resource "azurerm_subnet" "subnet" {
#     for_each = var.subnets

#     name = each.key
#     address_prefixes = [ each.value.address_prefix ]
#     resource_group_name = each.value.resource_group
#     virtual_network_name = each.value.vnets_name
#     depends_on = [ azurerm_resource_group.rg ]
# }