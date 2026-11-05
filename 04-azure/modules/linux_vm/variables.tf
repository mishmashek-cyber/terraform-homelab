variable "resource_group" {
  description = "Resource group name for the virtual machines"
  type        = string
}

variable "location" {
  description = "Azure region for the virtual machines"
  type        = string
}

variable "vm_defaults" {
  description = "Default configuration for Linux virtual machines"

  type = object({
    size              = string
    admin_username    = string
    public_ip_enabled = bool

    os_disk = object({
      caching              = string
      storage_account_type = string
    })

    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
  })
}

variable "vms" {
  description = "Linux virtual machines to deploy"

  type = map(object({
    name              = string
    public_ip_enabled = optional(bool)
  }))
}

variable "admin_ssh_public_key" {
  description = "SSH public key for the Linux VMs"
  type        = string
}

variable "tags" {
  description = "Tags applied to Linux VM resources"
  type        = map(string)
}

variable "subnet_id" {
  description = "Subnet ID for the virtual machine network interfaces"
  type        = string
}
