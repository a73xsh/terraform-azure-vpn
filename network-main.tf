####################
## Network - Main ##
####################

# Create a Resource Group
resource "azurerm_resource_group" "vpn-rg" {
  name     = "${var.prefix}-vpn-${var.app_name}-rg"
  location = var.location
  tags = {
    owner = var.owner
  }
}

# Create the VNET
resource "azurerm_virtual_network" "vpn-vnet" {
  name                = "${var.prefix}-vpn-${var.app_name}-vnet"
  address_space       = [var.vpn-vnet-cidr]
  location            = azurerm_resource_group.vpn-rg.location
  resource_group_name = azurerm_resource_group.vpn-rg.name
  tags = {
    owner = var.owner
  }
}

# Create a Gateway Subnet
resource "azurerm_subnet" "vpn-gateway-subnet" {
  name                 = "GatewaySubnet" # do not rename
  address_prefixes     = [var.vpn-gateway-subnet-cidr]
  virtual_network_name = azurerm_virtual_network.vpn-vnet.name
  resource_group_name  = azurerm_resource_group.vpn-rg.name
}

# Create a storage endpoint Subnet
resource "azurerm_subnet" "vpn-endpoint-subnet" {
  name                 = "Endpoint"
  address_prefixes     = [var.vpn-enpoint-subnet-cidr]
  virtual_network_name = azurerm_virtual_network.vpn-vnet.name
  resource_group_name  = azurerm_resource_group.vpn-rg.name
  enforce_private_link_endpoint_network_policies = true
}
