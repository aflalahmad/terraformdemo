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
    features {}
 
}


resource "azurerm_resource_group" "rg" {
    name = "myrg"
    location = "southeastasia"
  
}

resource "azurerm_resource_group" "rg1" {
    name = var.rgnew
    location = var.location
}