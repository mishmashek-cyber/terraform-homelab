terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "tfstatehomelab20261104"
    container_name       = "tfstate"
    key                  = "04-azure.tfstate"
  }
}
