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
