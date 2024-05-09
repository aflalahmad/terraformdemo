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

  locals {
    network = yamldecode(file("vnet.yaml"))
  }

  resource "azurerm_resource_group" "rg" {
    name = local.network.resource_group
    location = local.network.location
  }

  resource "azurerm_virtual_network" "virtualnetwork" {
    name = local.network.vnet
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    address_space = [ local.network.address_space ]
    dynamic "subnet" {
      for_each = local.network.subnets
      content {
        address_prefix = subnet.value.iprange
        name = subnet.value.name
      }
      
    }
  }