terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.9"
    }
  }
}

module "server" {
  source = "../../modules/server"

  server_name    = "app-dev-01"
  environment    = "dev"
  cpu_count      = 2
  memory_gb      = 8
  vlan           = "vlan-dev-100"
  backup_enabled = false
}
