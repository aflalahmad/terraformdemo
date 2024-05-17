locals {
  rules_csv = csvdecode(file(var.rules_file))
    nsg_names = [for i in range(var.nsg_count) : "nsg-subnet${i + 1}"]
    

}
