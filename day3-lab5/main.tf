variable "key" {
    type = list(string)
    default = [ "a","v","f" ]
  
}

variable "values" {
   type = list(number)
   default = [ "1","2","4" ]  
}

locals {
  mymap = zipmap(var.key,var.values)
}

output "mymap_output" {

    value = local.mymap
  
}