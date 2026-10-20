locals {
  environment = terraform.workspace
  file_path   = "${path.module}/${local.environment}.txt"
}
