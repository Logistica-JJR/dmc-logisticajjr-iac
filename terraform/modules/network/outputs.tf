output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "aca_subnet_id" {
  value = azurerm_subnet.aca_subnet.id
}

output "private_subnet_id" {
  value = azurerm_subnet.private_subnet.id
}
