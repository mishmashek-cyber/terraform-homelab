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

  server_name    = "app-test-01"
  environment    = "test"
  cpu_count      = 2
  memory_gb      = 8
  vlan           = "vlan-test-100"
  backup_enabled = true
}
