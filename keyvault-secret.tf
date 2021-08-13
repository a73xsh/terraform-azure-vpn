############################
## KeyVault Secret - Main ##
############################

# Variable for Certificate Name
locals {
  certificate-name = var.cert_root_name
}

# Create a Secret for the VPN Root certificate
resource "azurerm_key_vault_secret" "vpn-root-certificate" {
  depends_on = [azurerm_key_vault.vpn-keyvault]

  name         = "vpn-root-certificate"
  value        = filebase64(local.certificate-name)
  key_vault_id = azurerm_key_vault.vpn-keyvault.id

  tags = {
    owner = var.owner
  }
}
