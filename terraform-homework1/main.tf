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

#resource groups#

data "azurerm_resource_group" "rg" {
  name = "data-block-rg"
}


#virtual networks#
resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnetname[0]
  address_space       = [var.address_space[0]]
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

}

resource "azurerm_virtual_network" "vnet2" {
  name                = var.vnetname[1]
  address_space       = [var.address_space[1]]
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

}

resource "azurerm_virtual_network" "vnet3" {
  name                = var.vnetname[2]
  address_space       = [var.address_space[2]]
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

}

#subnets#

resource "azurerm_subnet" "vnet1subnet1" {
  name                 = "webserver1"
  address_prefixes     = [local.vnet1_subnet[0]]
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name

}
resource "azurerm_subnet" "vnet1subnet2" {
  name                 = "webserver2"
  address_prefixes     = [local.vnet1_subnet[1]]
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name

}


resource "azurerm_subnet" "vnet2subnet1" {
  name                 = "appserver1"
  address_prefixes     = [local.vnet2_subnet[0]]
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet2.name

}
resource "azurerm_subnet" "vnet2subnet2" {
  name                 = "appserver2"
  address_prefixes     = [local.vnet2_subnet[1]]
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet2.name

}


resource "azurerm_subnet" "vnet3subnet1" {
  name                 = "app1"
  address_prefixes     = [local.vnet3_subnet[0]]
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet3.name

}
resource "azurerm_subnet" "vnet3subnet2" {
  name                 = "app2"
  address_prefixes     = [local.vnet3_subnet[1]]
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet3.name

}



#network security groups#

resource "azurerm_network_security_group" "nsgvnet1subnet1" {
  name                = "nsg-vnet1-subnet1"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
}
resource "azurerm_network_security_group" "nsgvnet1subnet2" {
  name                = "nsg-vnet1-subnet2"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
}

resource "azurerm_network_security_group" "nsgvnet2subnet1" {
  name                = "nsg-vnet2-subnet1"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
}
resource "azurerm_network_security_group" "nsgvnet2subnet2" {
  name                = "nsg-vnet2-subnet2"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
}

resource "azurerm_network_security_group" "nsgvnet3subnet1" {
  name                = "nsg-vnet3-subnet1"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
}
resource "azurerm_network_security_group" "nsgvnet3subnet2" {
  name                = "nsg-vnet3-subnet2"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
}

#network security rules#
resource "azurerm_network_security_rule" "vnet1-subnet1-rule" {
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
  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsgvnet1subnet1.name
  depends_on                  = [azurerm_virtual_network.vnet1]
}

resource "azurerm_network_security_rule" "vnet1-subnet2-rule" {
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
  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsgvnet1subnet2.name
  depends_on                  = [azurerm_virtual_network.vnet1]
}


resource "azurerm_network_security_rule" "vnet2-subnet1-rule" {
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
  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsgvnet2subnet1.name
  depends_on                  = [azurerm_virtual_network.vnet2]
}

resource "azurerm_network_security_rule" "vnet2-subnet2-rule" {
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
  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsgvnet2subnet2.name
  depends_on                  = [azurerm_virtual_network.vnet2]
}


resource "azurerm_network_security_rule" "vnet3-subnet1-rule" {
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
  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsgvnet3subnet1.name
  depends_on                  = [azurerm_virtual_network.vnet3]
}

resource "azurerm_network_security_rule" "vnet3-subnet2-rule" {
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
  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsgvnet3subnet2.name
  depends_on                  = [azurerm_virtual_network.vnet3]
}

#network associate part#
resource "azurerm_subnet_network_security_group_association" "vnet1_subnet1_associate" {
  subnet_id                 = azurerm_subnet.vnet1subnet1.id
  network_security_group_id = azurerm_network_security_group.nsgvnet1subnet1.id
  depends_on                = [azurerm_network_security_rule.vnet1-subnet1-rule]
}
resource "azurerm_subnet_network_security_group_association" "vnet1_subnet2_associate" {
  subnet_id                 = azurerm_subnet.vnet1subnet2.id
  network_security_group_id = azurerm_network_security_group.nsgvnet1subnet2.id
  depends_on                = [azurerm_network_security_rule.vnet1-subnet2-rule]
}

resource "azurerm_subnet_network_security_group_association" "vnet2_subnet1_associate" {
  subnet_id                 = azurerm_subnet.vnet2subnet1.id
  network_security_group_id = azurerm_network_security_group.nsgvnet2subnet1.id
  depends_on                = [azurerm_network_security_rule.vnet2-subnet1-rule]
}
resource "azurerm_subnet_network_security_group_association" "vnet2_subnet2_associate" {
  subnet_id                 = azurerm_subnet.vnet2subnet2.id
  network_security_group_id = azurerm_network_security_group.nsgvnet2subnet2.id
  depends_on                = [azurerm_network_security_rule.vnet2-subnet2-rule]
}

resource "azurerm_subnet_network_security_group_association" "vnet3_subnet1_associate" {
  subnet_id                 = azurerm_subnet.vnet3subnet1.id
  network_security_group_id = azurerm_network_security_group.nsgvnet3subnet1.id
  depends_on                = [azurerm_network_security_rule.vnet3-subnet1-rule]
}
resource "azurerm_subnet_network_security_group_association" "vnet3_subnet2_associate" {
  subnet_id                 = azurerm_subnet.vnet3subnet2.id
  network_security_group_id = azurerm_network_security_group.nsgvnet3subnet2.id
  depends_on                = [azurerm_network_security_rule.vnet3-subnet2-rule]
}
