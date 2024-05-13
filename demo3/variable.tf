variable "rg" {
  type = map(object({
    name = string
    location       = string
  }))
}

variable "vnets" {
  type = map(object({
    resource_group = string
    location       = string
    address_prefix = string
    subnet_address_prefix = string
  }))
}
# variable "subnets" {
#   type = map(object({
#     vnets_name     = string
#     resource_group = string
#     address_prefix = string
#   }))

# }
