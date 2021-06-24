# Module Terraform VNET

################################
# Create the initial resource
################################

resource "azurerm_resource_group" "vnet" {
  name     = var.resource_group
  location = var.location

  tags = merge(
    var.common_tags,
    tomap(
      {"Component" = "Network"}
    )
  )
}

##################################
# Create the DDOS Protection Plan
##################################

resource "azurerm_network_ddos_protection_plan" "ddos" {
  count               = var.create_vnet && var.create_ddos ? 1: 0
  name                = format("%s-%s", var.name, "DDOS")
  location            = azurerm_resource_group.vnet.location
  resource_group_name = azurerm_resource_group.vnet.name

  tags = merge(
    var.common_tags,
    tomap(
      {"Component" = "Network"}
    )
  )
}

##################################
# Create the Initial VNET Network
##################################

resource "azurerm_virtual_network" "vnet" {
  count               = var.create_vnet ? 1 : 0
  name                = var.name
  address_space       = var.address_space
  location            = azurerm_resource_group.vnet.location
  resource_group_name = azurerm_resource_group.vnet.name
  dns_servers         = var.dns_servers

  # If var.crete_ddos is true then add the DDOS protection plan
  dynamic "ddos_protection_plan" {
    for_each = local.ddos_enabled

    content {
      id     = azurerm_network_ddos_protection_plan.ddos[0].id
      enable = true
    }
  }

  tags = merge(
    var.common_tags,
    tomap(
      {"Component" = "Network"}
    )
  )
}

#############################
# Create the Subnets
#############################

resource "azurerm_subnet" "subnets" {
  for_each               = var.subnets
    name                 = lookup(each.value, "name")
    address_prefixes     = [lookup(each.value, "cidr")]
    service_endpoints    = lookup(each.value, "service_endpoints")
    resource_group_name  = azurerm_resource_group.vnet.name
    virtual_network_name = azurerm_virtual_network.vnet[0].name
}

#############################
# Gateway subnet there can only be 1
#############################

resource "azurerm_subnet" "gateway" {
  count                = var.create_vnet && length(tolist(var.gateway_subnet)) > 0 ? 1 : 0
  name                 = "GatewaySubnet"
  address_prefixes     = [var.gateway_subnet[0]]
  resource_group_name  = azurerm_resource_group.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet[0].name
}

#############################
# Create the Public IP address for the VNET Gateway
#############################

resource "azurerm_public_ip" "GWIP" {
  count               = var.create_vnet && length(tolist(var.gateway_subnet)) > 0 ? 1 : 0
  name                = format("%s-%s", var.name, "GWIP")
  resource_group_name = azurerm_resource_group.vnet.name
  location            = azurerm_resource_group.vnet.location
  allocation_method   = "Dynamic"
  sku                 = "Standard"

  tags = merge(
    var.common_tags,
    tomap(
      {"Component" = "Network"}
    )
  )
}

#############################
# Create the Virtual Network Gateway
#############################

resource "azurerm_virtual_network_gateway" "VNetGW" {
  count               = var.create_vnet && length(tolist(var.gateway_subnet)) > 0 ? length(tolist(var.gateway_subnet)) : 0
  name                = format("%s-%s", var.name, "GW")
  resource_group_name = azurerm_resource_group.vnet.name
  location            = azurerm_resource_group.vnet.location

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = "false"
  enable_bgp    = "false"
  sku           = "Basic"

  ip_configuration {
    name                          = format("%s-%s", var.name, "GWIP")
    public_ip_address_id          = azurerm_public_ip.GWIP[0].id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway[0].id
  }

  vpn_client_configuration {
    address_space = var.vpn_clients

    root_certificate {
      name             = "PS2RootCert"
      public_cert_data = var.certificate_data
    }
  }

  tags = merge(
    var.common_tags,
    tomap(
      {"Component" = "Network"}
    )
  )
}
