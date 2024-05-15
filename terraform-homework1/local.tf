locals {
  vnet1_subnet = [
    cidrsubnet(var.address_space[0],8,1),
    cidrsubnet(var.address_space[0],8,2)
  ]
  vnet2_subnet = [
    cidrsubnet(var.address_space[1],4,1),
    cidrsubnet(var.address_space[1],4,2)
  ]
  vnet3_subnet = [
    cidrsubnet(var.address_space[2],4,3),
    cidrsubnet(var.address_space[2],4,4)
  ]
}


locals {
  ag_inbound_ports_map = {
    "100" : {
      destination_port = "80",
      source_address   = "*" # Add the source address prefix here
      access           = "Allow"
    },
    "140" : {
      destination_port = "81",
      source_address   = "*" # Add the source address prefix here
      access           = "Allow"
    },
    "110" : {
      destination_port = "443",
      source_address   = "*" # Add the source address prefix here
      access           = "Allow"
    },
    "130" : {
      destination_port = "65200-65535",
      source_address   = "GatewayManager" # Add the source address prefix here
      access           = "Allow"
    }
    "150" : {
      destination_port = "8080",
      source_address   = "AzureLoadBalancer" # Add the source address prefix here
      access           = "Allow"
    }
    "4096" : {
      destination_port = "8080",
      source_address   = "Internet" # Add the source address prefix here
      access           = "Deny"
    }
  }
}