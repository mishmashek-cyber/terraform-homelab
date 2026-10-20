variable "server_name" {
  description = "Hostname of the server"
  type        = string
}

variable "environment" {
  description = "Environment where the server is deployed"
  type        = string
}

variable "cpu_count" {
  description = "Number of virtual CPUs"
  type        = number
}

variable "memory_gb" {
  description = "Amount of memory in GB"
  type        = number
}

variable "vlan" {
  description = "VLAN assigned to the server"
  type        = string
}

variable "backup_enabled" {
  description = "Whether backup is enabled for the server"
  type        = bool
}
