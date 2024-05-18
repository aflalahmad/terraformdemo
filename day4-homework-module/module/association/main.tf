resource "azurerm_subnet_network_group_association" "nsg-associate" {
       for_each = var.nsg_maps
       subnet_id = each.key
         network_security_group_id = each.value

}