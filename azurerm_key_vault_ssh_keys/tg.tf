provider "azurerm" {
  version = "~>1.33"
}

provider "null" {
    version = "~> 2.1.2"
}

terraform {
  backend "azurerm" {}
}
