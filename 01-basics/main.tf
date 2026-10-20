terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
    }
  }
}

resource "local_file" "hello" {
  filename        = "${path.module}/${var.file_name}"
  content         = var.file_content
  file_permission = var.file_permission
}

data "local_file" "existing" {
  filename = local.file_path
}
