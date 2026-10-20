output "server_name" {
  description = "Name of the configured server"
  value       = var.server_name
}

output "config_file" {
  description = "Path to the generated server configuration"
  value       = local_file.server_config.filename
}
