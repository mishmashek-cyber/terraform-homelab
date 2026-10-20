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

  server_name    = "app-prod-01"
  environment    = "prod"
  cpu_count      = 4
  memory_gb      = 16
  vlan           = "vlan-prod-100"
  backup_enabled = true
}
