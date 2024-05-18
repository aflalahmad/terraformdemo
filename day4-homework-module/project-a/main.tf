terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.1.0"
    }
  }
  required_version = ">= 1.1.0"
}


provider "azurerm" {
  features {

  }
}

module "resource_group" {

  source     = "../module/resourcegroup"
  rg-details = "Team-A"
  location   = "eastus"

}

module "virtual_network" {
  source        = "../module/virtualnetwork"
  vnet-name     = "vnet-1"
  rg-details    = "Team-A"
  location      = "eastus"
  address_space = ["10.1.0.0/16"]
  subnet-name   = "subnet"
  subnet-count  = 4
  subnet-bits   = 8


}

module "network-security-group" {

  source = "../module/networksecuritygroup"
  nsg-name = {
    nsg1 = { name = "nsg1" }
    nsg2 = { name = "nsg2" }
    nsg3 = { name = "nsg3" }
    nsg4 = { name = "nsg4" }
  }
  location = "eastus"
  rg-details = "Team-A"
}

