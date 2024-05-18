variable "vnet-name" {
    type = string
  
}
variable "rg-details" {
    type = string
  
}
variable "location" {
    type = string
  
}
variable "address_space" {
  type = list(string)
}

variable "subnet-name" {
    type = string
  
}
variable "subnet-count" {

    type = number
  
}
variable "subnet-bits" {
    type = number
  
}