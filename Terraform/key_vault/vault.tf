provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "myrg" {
  name     = "keyword"
  location = "Central India"
}

resource "azurerm_key_vault" "myvault" {
  name                        = "secret-1234"
  location                    = azurerm_resource_group.myrg.location
  resource_group_name         = azurerm_resource_group.myrg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.cred.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = true
  soft_delete_retention_days  = 7

  access_policy {
    tenant_id = data.azurerm_client_config.cred.tenant_id
    object_id = data.azurerm_client_config.cred.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
      "Set",
      "List",
      "Delete",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

data "azurerm_client_config" "cred" {}


resource "azurerm_key_vault_secret" "user_id" {
    depends_on = [ azurerm_key_vault.myvault ]
  name         = "user-id"
  value        = "cloud"
  key_vault_id = azurerm_key_vault.myvault.id
}

resource "azurerm_key_vault_secret" "password" {
    depends_on = [ azurerm_key_vault.myvault ]
  name         = "password"
  value        = "cloud@1234567"
  key_vault_id = azurerm_key_vault.myvault.id
}

#this code will create a azure vault and store a username and password