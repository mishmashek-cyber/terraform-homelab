output "vm_private_ips" {
  description = "Private IP addresses of the Linux VMs"
  value       = module.linux_vm.vm_private_ips
}

output "vm_public_ips" {
  description = "Public IP addresses of VMs with public IP enabled"
  value       = module.linux_vm.vm_public_ips
}

output "network_watcher_rg" {
  description = "Information about the existing Network Watcher resource group"

  value = {
    id       = data.azurerm_resource_group.network_watcher.id
    name     = data.azurerm_resource_group.network_watcher.name
    location = data.azurerm_resource_group.network_watcher.location
  }
}
