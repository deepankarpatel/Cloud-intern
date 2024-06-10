
resource "azurerm_resource_group" "name" {
  name = var.resource_group_name
  location = var.location
}
resource "azurerm_lb" "name" {
  name = var.lb_name
  resource_group_name = var.resource_group_name
  location = var.location
}