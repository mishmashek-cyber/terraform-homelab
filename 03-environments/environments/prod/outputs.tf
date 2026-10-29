output "server_name" {
  value = module.server.server_name
}

output "server_config_file" {
  value = module.server.config_file
}
output "server_ip" {
  description = "IP address of the PROD server"
  value       = module.server.ip_address
}
