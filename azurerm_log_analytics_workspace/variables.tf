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

# Log analytics workspace related variables

variable "azurerm_log_analytics_workspace_sku" {
  description = "The SKU of the log analytics workspace. PerGB2018."
  default     = "PerGB2018"
}

variable "log_analytics_workspace_name_suffix" {
  description = "The suffix to add to the log analytics name to distinguish it from others."
}

variable "azurerm_log_analytics_solution_list" {
  description = "List of solutions to configure within the logs analytics."
  type = "list"
}

locals {
  # Define resource names based on the following convention:
  # {azurerm_resource_name_prefix}-RESOURCE_TYPE-{environment}
  azurerm_resource_group_name          = "${var.resource_name_prefix}-${var.environment}-rg"
  azurerm_log_analytics_workspace_name = "${var.resource_name_prefix}-${var.environment}-log-analytics-workspace-${var.log_analytics_workspace_name_suffix}"
}
