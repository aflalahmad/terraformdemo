resource "azurerm_network_security_group" "nsg-names" {
    for_each = var.nsg-name
    name = each.value.name
    resource_group_name = var.rg-details
    location = var.location
}