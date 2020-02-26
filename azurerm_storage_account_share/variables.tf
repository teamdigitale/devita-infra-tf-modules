# General Variables

variable "environment" {
  description = "The nick name identifying the type of environment (i.e. test, staging, production)."
}

variable "location" {
  description = "The data center location where all resources will be put into."
}

variable "resource_name_prefix" {
  description = "The prefix used to name all resources created."
}

variable "storage_account_name" {
  description = "The suffix used to identify the specific Azure storage account."
}

variable "storage_account_share_name_suffix" {
  description = "The suffix used to identify the specific Azure storage account share."
}

variable "azurerm_storage_share_quota" {
  description = "The maximum size of the share, in gigabytes. Must be greater than 0, and less than or equal to 5 TB (5120 GB)."
}

locals {
  storage_account_resource_name_prefix = "${replace(var.resource_name_prefix, "-", "")}"
  # Define resource names based on the following convention:
  # {azurerm_resource_name_prefix}-RESOURCE_TYPE-{environment}
  azurerm_resource_group_name          = "${var.resource_name_prefix}-${var.environment}-rg"
  azurerm_storage_share_name           = "${var.resource_name_prefix}-${var.environment}-sashare-${var.storage_account_share_name_suffix}"
  azurerm_storage_account_name         = "${local.storage_account_resource_name_prefix}${var.environment}sa${var.storage_account_name}"
}
