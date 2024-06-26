
# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0, < 4.0.0"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "random_string" "random" {
  length  = 4
  special = false
}


resource "azurerm_resource_group" "rg" {
  name     =upper("${local.rgname}-${random_string.random.result}")
  location = local.location

}

resource "azurerm_storage_account" "storageaccount" {
  name                     = "${local.storage_account}${random_string.random.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier              = "Standard"
  account_replication_type = "LRS"
  depends_on               = [azurerm_resource_group.rg]
}
