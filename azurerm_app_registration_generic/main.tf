# New infrastructure

resource "azuread_application" "app" {
  name = "${local.azuread_application_name}"
}
