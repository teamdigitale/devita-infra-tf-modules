provider "azurerm" {
  version = "~>1.32"
}

provider "azuread" {
  version = "~>0.5.1"
}

terraform {
  backend "azurerm" {}
}
