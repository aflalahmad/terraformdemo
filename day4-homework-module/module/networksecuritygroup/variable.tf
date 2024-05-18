variable "nsg-name" {
    type = map(object({
      name = string
    }))
  
}
variable "rg-details" {
    type = string
  
}
variable "location" {
  type = string
}

