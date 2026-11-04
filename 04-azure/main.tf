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

resource "azurerm_public_ip" "vm" {
  name                = "pip-linux-dev-01"
  location            = azurerm_virtual_network.dev.location
  resource_group_name = azurerm_resource_group.dev.name
  allocation_method   = "Static"

  tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}

resource "azurerm_network_interface" "vm" {
  name                = "nic-linux-dev-01"
  location            = azurerm_virtual_network.dev.location
  resource_group_name = azurerm_resource_group.dev.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.app.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm.id
  }

  tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}

resource "azurerm_network_security_group" "app" {
  name                = "nsg-app-dev"
  location            = azurerm_virtual_network.dev.location
  resource_group_name = azurerm_resource_group.dev.name

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

  resource_group_name         = azurerm_resource_group.dev.name
  network_security_group_name = azurerm_network_security_group.app.name
}


resource "azurerm_subnet_network_security_group_association" "app" {
  subnet_id                 = azurerm_subnet.app.id
  network_security_group_id = azurerm_network_security_group.app.id
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-linux-dev-01"
  resource_group_name = azurerm_resource_group.dev.name
  location            = azurerm_virtual_network.dev.location
  size                = "Standard_B2ts_v2"
  admin_username      = "azureadmin"

  network_interface_ids = [
    azurerm_network_interface.vm.id
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

resource "azurerm_network_interface" "vm02" {
  name                = "nic-linux-dev-02"
  location            = azurerm_virtual_network.dev.location
  resource_group_name = azurerm_resource_group.dev.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.app.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}

resource "azurerm_linux_virtual_machine" "vm02" {
  name                = "vm-linux-dev-02"
  resource_group_name = azurerm_resource_group.dev.name
  location            = azurerm_virtual_network.dev.location
  size                = "Standard_B2ts_v2"
  admin_username      = "azureadmin"

  network_interface_ids = [
    azurerm_network_interface.vm02.id
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
