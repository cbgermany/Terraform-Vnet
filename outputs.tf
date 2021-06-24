# List of outputs available available

output "location" {
  description = "The region where the Vnet is created"
  value       = azurerm_resource_group.vnet.location
}

output "id" {
  description = "The ID of the newly created VNet"
  value       = azurerm_virtual_network.vnet.0.id
}

output "address_space" {
  description = "The CIDR block for the VNET"
  value       = azurerm_virtual_network.vnet.0.address_space
}

output "name" {
  description = "The name of the newly created VNet"
  value       = azurerm_virtual_network.vnet.0.name
}

# Subnets outputs

output "subnet_ids" {
  description = "list of IDs of the Sysman Subnets"
  value       = [azurerm_subnet.subnets.*.id]
}

output "subnet_names" {
  description = "The list of the subnet names"
  value       = [azurerm_subnet.subnets.*.name]
}

output "subnets_cidr_blocks" {
  description = "List of cidr_blocks of Sysman Subnets"
  value       = [azurerm_subnet.subnets.*.address_prefix]
}

output "gateway_subnet" {
  description = "The ID of the Gateway Subnets"
  value       = azurerm_subnet.gateway.0.id
}

output "gateway_subnet_cidr_block" {
  description = "The cidr_block of Gateway Subnet"
  value       = azurerm_subnet.gateway.0.address_prefix
}

output "virtual_network_gateway_id" {
  description = "The ID of the Virtual Network Gateway, used for VNET to VNET connectivity"
  value       = element(azurerm_virtual_network_gateway.VNetGW.*.id, 0)
}
