data "azurerm_resource_group" "rg" {
  name = "${local.azurerm_resource_group_name}"
}

# New infrastructure resources

resource "azurerm_data_factory" "data_factory" {
  name                 = "${local.azurerm_data_factory_name}"
  resource_group_name  = "${data.azurerm_resource_group.rg.name}"
  location             = "${data.azurerm_resource_group.rg.location}"

  tags = {
    environment = "${var.environment}"
  }
}
