resource "azurerm_resource_group" "rs-group" {
  name     = "${var.environment}-hmw-resources"
  location = var.location
  tags = {
    environment = var.environment
    managed_by  = "terraform"
  }
}
