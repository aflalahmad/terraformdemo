variable "team_members" {
    type = list(object({
      name = string
      age = number
      location = object({
        city = string 
      })
    }))
  default = [
     {
    name = "aflal"
    age = "21"
    location = {
      city = "lalpet"
    }
  },
  {
  name = "hashim"
  age = "2"
  location = {
    city = "sg"
  }
  }
   ]
}

resource "null_resource" "expl" {
   count = length(var.team_members)


triggers = {
    name = var.team_members[count.index]["name"]
    age = var.team_members[count.index]["age"]
    city = var.team_members[count.index]["location"]["city"]
}
}