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


data "azurerm_resource_group" "rg" {
  name = "data-block-rg"
}

resource "azurerm_virtual_network" "vnet1" {
  name = "vnet1"
  address_space = [ "10.0.0.0/16" ]
  resource_group_name = data.azurerm_resource_group.rg.name
  location = data.azurerm_resource_group.rg.location
  
}

resource "azurerm_virtual_network" "vnet2" {
  name = "vnet2"
  address_space = [ "10.0.0.0/24" ]
  resource_group_name = data.azurerm_resource_group.rg.name
  location = data.azurerm_resource_group.rg.location
  
}

resource "azurerm_subnet" "webserver1" {
    name = "webserver1"
    address_prefixes = [ local.vnet1_subnets[0] ]
    resource_group_name = data.azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet1.name
    depends_on = [ data.azurerm_resource_group.rg ]
}

resource "azurerm_subnet" "appserver1" {
   name = "appserver1"
   address_prefixes = [ local.vnet2_subnets[1] ]
    resource_group_name = data.azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet1.name
    depends_on = [ data.azurerm_resource_group.rg ]
}

resource "azurerm_subnet" "webserver2" {
    name = "webserver2"
    address_prefixes = [ local.vnet2_subnets[0] ]
    resource_group_name = data.azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet2.name
    depends_on = [ data.azurerm_resource_group.rg ]
}

resource "azurerm_subnet" "appserver2" {
   name = "appserver2"
   address_prefixes = [local.vnet2_subnets[1] ]
    resource_group_name = data.azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet2.name
    depends_on = [ data.azurerm_resource_group.rg ]
}


resource "azurerm_network_security_group" "nsg_subnet1_vnet1" {
  name = "nsg-subnet1-vnet1"
  resource_group_name = data.azurerm_resource_group.rg.name
  location = data.azurerm_resource_group.rg.location
  
}

resource "azurerm_network_security_group" "nsg_subnet2_vnet1" {
  name = "nsg-subnet2-vnet1"
  resource_group_name = data.azurerm_resource_group.rg.name
  location = data.azurerm_resource_group.rg.location
}
resource "azurerm_network_security_group" "nsg_subnet1_vnet2" {
  name = "nsg-subnte1-vnet2"
  resource_group_name = data.azurerm_resource_group.rg.name
  location = data.azurerm_resource_group.rg.location
  
}
resource "azurerm_network_security_group" "nsg_subnet2_vnet2" {
  name = "nsg-subnet2-vnet2"
  resource_group_name = data.azurerm_resource_group.rg.name
  location = data.azurerm_resource_group.rg.location
  
}

resource "azurerm_network_security_rule" "subnet1-vnet1-rule" {
  
  for_each = local.ag_inbound_ports_map
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
    network_security_group_name = azurerm_network_security_group.nsg_subnet1_vnet1.name
    depends_on = [ azurerm_virtual_network.vnet1 ]

}
resource "azurerm_network_security_rule" "subnet2-vnet1-rule" {
  
  for_each = local.ag_inbound_ports_map
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
    network_security_group_name = azurerm_network_security_group.nsg_subnet2_vnet1.name
    depends_on = [ azurerm_virtual_network.vnet1 ]

}
resource "azurerm_network_security_rule" "subnet1-vnet2-rule" {
  
  for_each = local.ag_inbound_ports_map
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
    network_security_group_name = azurerm_network_security_group.nsg_subnet1_vnet2.name
    depends_on = [ azurerm_virtual_network.vnet1 ]

}
resource "azurerm_network_security_rule" "subnet2-vnet2-rule" {
  
  for_each = local.ag_inbound_ports_map
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
    network_security_group_name = azurerm_network_security_group.nsg_subnet2_vnet2.name
    depends_on = [ azurerm_virtual_network.vnet1 ]

}

resource "azurerm_subnet_network_security_group_association" "subnet1_vnet1_associate" {
   subnet_id = azurerm_subnet.appserver1.id
   network_security_group_id = azurerm_network_security_group.nsg_subnet1_vnet1.id
   depends_on = [ azurerm_network_security_rule.subnet1-vnet1-rule ]
}
resource "azurerm_subnet_network_security_group_association" "subnet2_vnet1_associate" {
   subnet_id = azurerm_subnet.webserver1.id
   network_security_group_id = azurerm_network_security_group.nsg_subnet2_vnet1.id
   depends_on = [ azurerm_network_security_group.nsg_subnet1_vnet1 ]
}
resource "azurerm_subnet_network_security_group_association" "subnet1_vnet2_associate" {
   subnet_id = azurerm_subnet.webserver2.id
   network_security_group_id = azurerm_network_security_group.nsg_subnet1_vnet2.id
   depends_on = [ azurerm_network_security_group.nsg_subnet1_vnet2 ]
}
resource "azurerm_subnet_network_security_group_association" "subnet2_vnet2_associate" {
   subnet_id = azurerm_subnet.appserver2.id
   network_security_group_id = azurerm_network_security_group.nsg_subnet2_vnet2.id
   depends_on = [ azurerm_network_security_group.nsg_subnet2_vnet2 ]
}
