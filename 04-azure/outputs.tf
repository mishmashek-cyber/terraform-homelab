output "vm_private_ips" {
  description = "Private IP addresses of the Linux VMs"

  value = {
    for key, vm in azurerm_linux_virtual_machine.vm :
    key => vm.private_ip_address
  }
}

output "vm_public_ips" {
  description = "Public IP addresses of VMs with public IP enabled"

  value = {
    for key, ip in azurerm_public_ip.vm :
    key => ip.ip_address
  }
}

output "network_watcher_rg" {
  description = "Information about the existing Network Watcher resource group"

  value = {
    id       = data.azurerm_resource_group.network_watcher.id
    name     = data.azurerm_resource_group.network_watcher.name
    location = data.azurerm_resource_group.network_watcher.location
  }
}
