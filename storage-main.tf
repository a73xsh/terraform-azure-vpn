#####################
## Storage- Main   ##
#####################

resource "azurerm_storage_account" "vpn_vpn_storage_account" {
  name                      = "${var.prefix}${var.app_name}st"
  depends_on                = [azurerm_virtual_network_gateway.vpn-gateway]
  resource_group_name       = azurerm_resource_group.vpn-rg.name
  location                  = azurerm_resource_group.vpn-rg.location
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  
  network_rules {
      default_action             = "Deny"
    }
    
  tags = {
    owner = var.owner
  }
}

/* resource "azurerm_storage_container" "vpn_vpn_storage_container" {
  name                  = "vpnprivate"
  depends_on            = [azurerm_storage_account.vpn_vpn_storage_account]
  storage_account_name  = azurerm_storage_account.vpn_vpn_storage_account.name
  container_access_type = "private"
} */

resource "azurerm_private_endpoint" "vpn_vpn_storage_pe" {
  name                = "${var.prefix}-${var.app_name}-pe"
  location            = azurerm_resource_group.vpn-rg.location
  resource_group_name = azurerm_resource_group.vpn-rg.name
  subnet_id           = azurerm_subnet.vpn-endpoint-subnet.id

  private_service_connection {
    name                           = "${var.prefix}-${var.app_name}-psc"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.vpn_vpn_storage_account.id
    subresource_names              = ["blob"]
  }

}
