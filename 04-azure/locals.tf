locals {
  common_tags = {
    managed_by = "terraform"
  }

  environment_tags = {
    environment = var.environment.name
  }

  tags = merge(
    local.common_tags,
    local.environment_tags
  )
}
