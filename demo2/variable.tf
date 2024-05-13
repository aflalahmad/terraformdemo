variable "vnets" {

    type = map(object({
       address_prefix = string
       resource_group = string
       location = string
    }))
  
}