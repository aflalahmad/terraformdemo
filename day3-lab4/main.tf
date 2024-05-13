variable "team_members" {
    type = map(object({
      name = string
      age = number
      location = object({
        city = string 
      })
    }))

    default = {
      "Aflal" = {
        name = "hello"
        age= "0"
        location = {
            city = "new york"
        }
      },
      "hashim" = {
        name = "mf"
        age = "4"
        location = {
            city = "sg"
        }
      }
    }
  
}

resource "null_resource" "exmple" {
       for_each = var.team_members

       triggers = {
        name = each.value["name"]
        age = each.value["age"]
        city = each.value["location"]["city"]
       }  
}