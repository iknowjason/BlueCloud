###################################################################################################
# Outputs
####################################################################################################

output "dc_subnet_subnet_id" {
  value = azurerm_subnet.dc-subnet.id
}

output "user1_subnet_subnet_id" {
  value = azurerm_subnet.user1-subnet.id
}

output "out_resource_group_name" {
  value = azurerm_resource_group.network.name
}
