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

data "azurerm_resource_group" "rg" {

  name = "data-block-rg"
}

resource "azurerm_storage_account" "storageaccount" {

    name = "stacc33333"
    resource_group_name = data.azurerm_resource_group.rg.name
    location = data.azurerm_resource_group.rg.location
    account_tier = "Standard"
    account_replication_type = "LRS"
  
}