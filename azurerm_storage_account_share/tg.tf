provider "azurerm" {
  version = "~>1.36"
}

provider "azuread" {
  version = "~>0.5.1"
}

terraform {
  backend "azurerm" {}
}
