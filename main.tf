resource "azurerm_resource_group" "teja-test-RG" {
  name     = "teja-test-RG"
  location = "East US"
}

resource "azurerm_key_vault" "teja-test-kv-21201" {
  name                     = "teja-test-kv-21201"
  location                 = azurerm_resource_group.teja-test-RG.location
  resource_group_name      = azurerm_resource_group.teja-test-RG.name
  tenant_id                = "d207c7bd-fcb1-4dd3-855a-cfd2f9b651e8" # Replace with your Azure tenant ID
  sku_name                 = "standard"
  purge_protection_enabled = true
  soft_delete_retention_days  = 7

  network_acls {
    default_action = var.action
    bypass         = "AzureServices"

    ip_rules = [
      "192.168.1.1",
      "192.168.2.0/24"
    ]

    virtual_network_subnet_ids = [
      "/subscriptions/26a1a07e-06dd-4892-92c9-e4996b0fc546/resourceGroups/testmanaged/providers/Microsoft.Network/virtualNetworks/test-vn-123/subnets/default"
    ]
  }

  tags = {
    environment = "example"
  }
}

