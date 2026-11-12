locals {
  public_ip_vms = {
    for key, vm in var.vms : key => vm
    if coalesce(vm.public_ip_enabled, var.vm_defaults.public_ip_enabled)
  }
  public_ip_address_ids = {
    for key, vm in var.vms : key => (
      coalesce(
        vm.public_ip_enabled,
        var.vm_defaults.public_ip_enabled
      ) ? azurerm_public_ip.vm[key].id : null
    )
  }
}
