variable "admin_ssh_public_key" {
  description = "SSH public key for the Linux VM"
  type        = string
}

variable "environment" {
  description = "Environment configuration"

  type = object({
    name           = string
    resource_group = string
    location       = string

    network = object({
      name                    = string
      address_space           = list(string)
      subnet_name             = string
      subnet_address_prefixes = list(string)
      nsg_name                = string
      nsg_rules = map(object({
        name                       = string
        priority                   = number
        direction                  = string
        access                     = string
        protocol                   = string
        source_port_range          = string
        destination_port_range     = string
        source_address_prefix      = string
        destination_address_prefix = string
      }))
    })

    vm_defaults = object({

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
    vms = map(object({
      name              = string
      public_ip_enabled = optional(bool)
    }))
  })
}
