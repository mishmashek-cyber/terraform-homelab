resource "azurerm_resource_group" "dev" {
  name     = "rg-terraform-dev"
  location = "West Europe"

  tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}


resource "azurerm_virtual_network" "dev" {
  name                = "vnet-terraform-dev"
  address_space       = ["10.10.0.0/16"]
  location            = "Sweden Central"
  resource_group_name = azurerm_resource_group.dev.name

  tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}

resource "azurerm_subnet" "app" {
  name                 = "snet-app-dev"
  resource_group_name  = azurerm_resource_group.dev.name
  virtual_network_name = azurerm_virtual_network.dev.name
  address_prefixes     = ["10.10.1.0/24"]
}
