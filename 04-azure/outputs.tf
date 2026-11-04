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
