# List of outputs available available

output "vnet" {
  description = "VNET resource"
  value       = azurerm_virtual_network.vnet
}

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

output "subnets" {
  description = "Created subnet resources"
  value       = azurerm_subnet.subnets
}

output "gateway_subnet" {
  description = "The ID of the Gateway Subnets"
  value       = join("", azurerm_subnet.gateway.*.id)
}

output "gateway_subnet_cidr_block" {
  description = "The cidr_block of Gateway Subnet"
  value       = join("", azurerm_subnet.gateway.*.address_prefix)
}

output "virtual_network_gateway_id" {
  description = "The ID of the Virtual Network Gateway, used for VNET to VNET connectivity"
  value       = join("", azurerm_virtual_network_gateway.VNetGW.*.id)
}
