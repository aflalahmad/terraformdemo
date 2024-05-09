variable "rg" {
  type = map(object({
    name = string
    location = string
  }))
}

variable "vnets" {
    type = map(object({
      resource_group =string
      location=string
      address_prefix = string 
    }))
  
}