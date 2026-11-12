module "network" {
  source = "./modules/network"

  name                    = var.environment.network.name
  location                = var.environment.location
  resource_group_name     = var.environment.resource_group
  address_space           = var.environment.network.address_space
  subnet_name             = var.environment.network.subnet_name
  subnet_address_prefixes = var.environment.network.subnet_address_prefixes
  nsg_name                = var.environment.network.nsg_name
  nsg_rules               = var.environment.network.nsg_rules

  tags = local.tags
}

module "linux_vm" {
  source = "./modules/linux_vm"

  resource_group       = var.environment.resource_group
  location             = var.environment.location
  vm_defaults          = var.environment.vm_defaults
  vms                  = var.environment.vms
  admin_ssh_public_key = var.admin_ssh_public_key
  subnet_id            = module.network.subnet_id

  tags = local.tags
}

data "azurerm_resource_group" "network_watcher" {
  name = "NetworkWatcherRG"
}
