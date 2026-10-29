resource "azurerm_resource_group" "dev" {
  name     = "rg-terraform-dev"
  location = "West Europe"

  tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
