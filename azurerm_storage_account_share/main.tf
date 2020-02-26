# Existing infrastructure

data "azurerm_resource_group" "rg" {
  name = "${local.azurerm_resource_group_name}"
}

data "azurerm_storage_account" "storage_account" {
  name                = "${local.azurerm_storage_account_name}"
  resource_group_name = "${data.azurerm_resource_group.rg.name}"
}

# New infrastructure

resource "azurerm_storage_share" "storage_account_share" {
  name                 = "${local.azurerm_storage_share_name}"
  storage_account_name = "${data.azurerm_storage_account.storage_account.name}"
  quota                = "${var.azurerm_storage_share_quota}"
}
