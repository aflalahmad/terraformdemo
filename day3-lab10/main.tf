terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
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
  name     = "RGnew"
  location = "southeastasia"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "myVnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet1" {

  name                 = "frontend"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
  depends_on           = [azurerm_resource_group.rg]

}

resource "azurerm_subnet" "subnet2" {
  name                 = "backend"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
  depends_on           = [azurerm_resource_group.rg]

}

resource "azurerm_subnet" "subnet3" {

  name                 = "workload"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
  depends_on           = [azurerm_resource_group.rg]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "subnet_nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  depends_on          = [azurerm_resource_group.rg]
}

resource "azurerm_network_security_rule" "inboundrule" {
  for_each                    = local.ag_inbound_ports_map
  name                        = "Rule-port-${each.value.destination_port}-${each.value.access}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = each.value.access
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value.destination_port
  source_address_prefix       = each.value.source_address
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
  depends_on                  = [azurerm_virtual_network.vnet]
}

resource "azurerm_subnet_network_security_group_association" "subnet_associate" {
  depends_on                = [azurerm_network_security_rule.inboundrule]
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg.id

}
