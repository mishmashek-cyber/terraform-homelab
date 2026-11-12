resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.vms

  name                = "vm-${each.value.name}"
  resource_group_name = var.resource_group
  location            = var.location
  size                = var.vm_defaults.size
  admin_username      = var.vm_defaults.admin_username

  network_interface_ids = [
    azurerm_network_interface.vm[each.key].id
  ]

  admin_ssh_key {
    username   = var.vm_defaults.admin_username
    public_key = var.admin_ssh_public_key
  }

  os_disk {
    caching              = var.vm_defaults.os_disk.caching
    storage_account_type = var.vm_defaults.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = var.vm_defaults.source_image_reference.publisher
    offer     = var.vm_defaults.source_image_reference.offer
    sku       = var.vm_defaults.source_image_reference.sku
    version   = var.vm_defaults.source_image_reference.version
  }

  tags = var.tags
}

resource "azurerm_network_interface" "vm" {
  for_each = var.vms

  name                = "nic-${each.value.name}"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"

    # Public IP připojíme jen VM, která ho má
    public_ip_address_id = local.public_ip_address_ids[each.key]
  }

  tags = var.tags
}

resource "azurerm_public_ip" "vm" {
  for_each = local.public_ip_vms

  name                = "pip-${each.value.name}"
  resource_group_name = var.resource_group
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}
