variable "vnets" {
  type = map(object({
      address_space = string
      Subnets = list(object({
        name = string
        newbits = number
        netnum = number
      })) 
  }))

  default = {
    vnet1 = {
      address_space = "10.0.0.0/16"
      Subnets = [
        {name = "vnet1subnet1" , newbits = 8 , netnum = 1},
        {name = "vnet1subnet2" , newbits = 8 , netnum = 2}
      ]
    },

    vnet2 = {
       address_space = "10.0.0.0/24"
       Subnets = [
        {name = "vnet2subnet1" , newbits = 4 , netnum = 1},
        {name = "vnet2subnet2" , newbits = 4 , netnum = 2}
       ]
    }
  }
}

variable "nsg_count" {
  type = string
     default = 4
}

variable "rules_file" {
    type = string
    default = "rules-20.csv"
  
}

