# General Variables

variable "environment" {
  description = "The nick name identifying the type of environment (i.e. test, staging, production)"
}

variable "location" {
  description = "The data center location where all resources will be put into."
}

variable "resource_name_prefix" {
  description = "The prefix used to name all resources created."
}

# App registration variables

variable "azuread_application_name_suffix" {
  description = " The display name for the application."
}

locals {
  # Define resource names based on the following convention:
  # {azurerm_resource_name_prefix}-RESOURCE_TYPE-{environment}
  azuread_application_name     = "${var.resource_name_prefix}-${var.environment}-app-${var.azuread_application_name_suffix}"
}
