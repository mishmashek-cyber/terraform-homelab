variable "admin_ssh_public_key" {
  description = "SSH public key for the Linux VM"
  type        = string
}

variable "vms" {
  description = "Linux virtual machines to deploy"
  type = map(object({
    name              = string
    size              = string
    public_ip_enabled = bool
  }))
}

variable "environment" {
  description = "Environment configuration"

  type = object({
    name           = string
    resource_group = string

    network = object({
      name                    = string
      location                = string
      address_space           = list(string)
      subnet_name             = string
      subnet_address_prefixes = list(string)
    })
  })
}
