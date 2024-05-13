locals {
  fruits = ["apple","orange","banana"]
}

resource "null_resource" "expl" {
  count = length(local.fruits)
}

output "expl" {

    value = null_resource.expl[*].triggers
  
}