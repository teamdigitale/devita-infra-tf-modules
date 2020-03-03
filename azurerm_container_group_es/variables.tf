# General variables

variable "environment" {
  description = "The nick name identifying the type of environment (i.e. test, staging, production)."
}

variable "resource_name_prefix" {
  description = "The prefix used to name all resources created."
}

variable "location" {
  description = "The data center location where all resources will be put into."
}

# Storage account

variable "storage_account_name_suffix" {
  description = "The suffix used to identify the specific Azure storage account"
}

variable "storage_account_share_name_suffix" {
  description = "The suffix used to identify the specific Azure storage account share."
}

# ACI

variable "container_group_name_suffix" {
  description = "The suffix of the Azure Container Instance name."
}

# Log analytics related variables

variable "log_analytics_workspace_name" {
  description = "The name of the log analytics workspace. It will be used as the logs analytics workspace name suffix."
}

locals {
  storage_account_resource_name_prefix = "${replace(var.resource_name_prefix, "-", "")}"

  # Define resource names based on the following convention:
  # {azurerm_resource_name_prefix}-RESOURCE_TYPE-{environment}
  azurerm_resource_group_name          = "${var.resource_name_prefix}-${var.environment}-rg"
  azurerm_container_group_name         = "${var.resource_name_prefix}-${var.environment}-aci-${var.container_group_name_suffix}"
  azurerm_log_analytics_workspace_name = "${var.resource_name_prefix}-${var.environment}-${var.log_analytics_workspace_name}"
  azurerm_storage_account_name         = "${local.storage_account_resource_name_prefix}${var.environment}sa${var.storage_account_name_suffix}"
  azurerm_storage_share_name           = "${var.resource_name_prefix}-${var.environment}-sashare-${var.storage_account_share_name_suffix}"
}
