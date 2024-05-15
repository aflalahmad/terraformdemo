variable "vnetname" {

   type = list(string)
   default = [ "vnet1","vnet2","vnet3" ]    
    
  
}
variable "address_space" {

    type = list(string)
    default = [ "10.0.0.0/16","10.0.0.0/24","10.0.0.0/20" ]
  
}