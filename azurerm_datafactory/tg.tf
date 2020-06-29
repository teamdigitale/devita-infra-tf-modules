provider "azurerm" {
  version = "~>1.44"
}

terraform {
  backend "azurerm" {}
}
