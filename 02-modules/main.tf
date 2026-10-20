terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.9"
    }
  }
}

module "servers" {
  for_each = {
    web01 = {
      filename = "web-01.txt"
      content  = "Configuration for WEB-01"
    }
    web03 = {
      filename = "web-03.txt"
      content  = "Configuration for WEB-03"
    }
  }

  source   = "./modules/file"
  filename = "${path.root}/${each.value.filename}"
  content  = each.value.content
}

resource "local_file" "worker" {
  count = 3

  filename        = "${path.root}/worker-${count.index}.txt"
  content         = "Worker number ${count.index}"
  file_permission = "0644"
}

resource "local_file" "monitoring" {
  count = var.enable_monitoring ? 1 : 0

  filename        = "${path.root}/monitoring.conf"
  content         = "Monitoring enabled"
  file_permission = "0644"
}
