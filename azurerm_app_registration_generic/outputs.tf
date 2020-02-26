output "azuread_application_application_id" {
  description = "The id of the application created."
  value       = "${azuread_application.app.application_id}"
}
