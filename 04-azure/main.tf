module "network" {
  source = "./modules/network"

  name                    = var.environment.network.name
  location                = var.environment.network.location
  resource_group_name     = var.environment.resource_group
  address_space           = var.environment.network.address_space
  subnet_name             = var.environment.network.subnet_name
  subnet_address_prefixes = var.environment.network.subnet_address_prefixes

  tags = {
    environment = var.environment.name
    managed_by  = "terraform"
  }
}

resource "azurerm_public_ip" "vm" {
  for_each = {
    for key, vm in var.vms : key => vm
    if vm.public_ip_enabled
  }

  name                = "pip-${each.value.name}"
  resource_group_name = var.environment.resource_group
  location            = var.environment.network.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}



resource "azurerm_network_security_group" "app" {
  name                = "nsg-app-dev"
  location            = var.environment.network.location
  resource_group_name = var.environment.resource_group

  tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}

resource "azurerm_network_security_rule" "ssh" {
  name                       = "allow-ssh"
  priority                   = 100
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "22"
  source_address_prefix      = "193.179.215.98/32"
  destination_address_prefix = "*"

  resource_group_name         = var.environment.resource_group
  network_security_group_name = azurerm_network_security_group.app.name
}


resource "azurerm_subnet_network_security_group_association" "app" {
  subnet_id                 = module.network.subnet_id
  network_security_group_id = azurerm_network_security_group.app.id
}


resource "azurerm_network_interface" "vm" {
  for_each = var.vms

  name                = "nic-${each.value.name}"
  location            = var.environment.network.location
  resource_group_name = var.environment.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.network.subnet_id
    private_ip_address_allocation = "Dynamic"

    # Public IP připojíme jen VM, která ho má
    public_ip_address_id = each.value.public_ip_enabled ? azurerm_public_ip.vm[each.key].id : null
  }

  tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.vms

  name                = "vm-${each.value.name}"
  resource_group_name = var.environment.resource_group
  location            = var.environment.network.location
  size                = each.value.size
  admin_username      = "azureadmin"

  network_interface_ids = [
    azurerm_network_interface.vm[each.key].id
  ]

  admin_ssh_key {
    username   = "azureadmin"
    public_key = var.admin_ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}

data "azurerm_resource_group" "network_watcher" {
  name = "NetworkWatcherRG"
}
