output "vm_private_ips" {
  description = "Private IP addresses of the Linux VMs"

  value = {
    for key, nic in azurerm_network_interface.vm :
    key => nic.private_ip_address
  }
}

output "vm_public_ips" {
  description = "Public IP addresses of VMs with public IP enabled"

  value = {
    for key, pip in azurerm_public_ip.vm :
    key => pip.ip_address
  }
}
