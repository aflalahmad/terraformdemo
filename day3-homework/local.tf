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

locals {
  vnet1_subnets = [
    cidrsubnet("10.0.0.0/16", 8, 1), # 10.0.1.0/24
    cidrsubnet("10.0.0.0/16", 8, 2)  # 10.0.2.0/24
  ]
  vnet2_subnets = [
    cidrsubnet("10.0.0.0/24", 4, 1), # 10.0.0.64/26
    cidrsubnet("10.0.0.0/24", 4, 2)  # 10.0.0.128/26
  ]
}