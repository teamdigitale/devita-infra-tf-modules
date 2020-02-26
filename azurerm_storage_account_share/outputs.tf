output "azurerm_storage_account_share_name" {
  description = "The name of the storage account share generated."
  value       = "${local.azurerm_storage_share_name}"
}
