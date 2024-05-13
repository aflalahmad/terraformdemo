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

resource "azurerm_resource_group" "rg" {
  name = local.resource_group_name
  location = local.location
}

resource "azurerm_storage_account" "sc" {

    name = local.storageaccount_name
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    account_tier = "Standard"
    account_replication_type = local.account_replication_type
  
}