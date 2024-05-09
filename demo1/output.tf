output "rg" {
    value = azurerm_resource_group.rg.name
  
}

output "location" {
  value = azurerm_resource_group.rg.location
}

output "rg_id" {
    value = azurerm_resource_group.rg.id
  
}

output "virtualnetwork" {

    value = azurerm_virtual_network.example.name
  
}