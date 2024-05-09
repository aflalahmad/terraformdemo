variable "vnets" {
    type = map(object({
      resource_group = string
      location = string
      address_prefix = string
    }))
  
}