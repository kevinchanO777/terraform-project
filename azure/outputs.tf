# data "azurerm_public_ip" "dev_public_ip" {
#   name                = azurerm_public_ip.dev_public_ip.name
#   resource_group_name = azurerm_resource_group.dev_rg.name
# }

output "public_ip_address" {
  value = "${azurerm_linux_virtual_machine.dev_vm.name}: ${azurerm_public_ip.dev_public_ip.ip_address}"
}

output "resource_group_id" {
  value = azurerm_resource_group.dev_rg.id
}
