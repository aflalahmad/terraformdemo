resource "azurerm_virtual_network" "vnets" {
  name = var.vnet-name
  resource_group_name = var.rg-details
  location = var.location
  address_space = var.address_space
}

resource "azurerm_subnet" "subnets" {

  count                = var.subnet-count
  name                 = "${var.subnet-name}-${count.index + 1}"
  address_prefixes     = [cidrsubnet(var.address_space[0], var.subnet-bits, count.index)]
  resource_group_name  = var.rg-details
  virtual_network_name = azurerm_virtual_network.vnets.name
  
}