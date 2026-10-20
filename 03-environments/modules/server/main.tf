resource "local_file" "server_config" {
  filename = "${path.root}/${var.server_name}.txt"

  content = <<-EOT
    Hostname:    ${var.server_name}
    Environment: ${var.environment}
    CPU:         ${var.cpu_count}
    Memory:      ${var.memory_gb} GB
    VLAN:        ${var.vlan}
    Backup:      ${var.backup_enabled ? "enabled" : "disabled"}
  EOT

  file_permission = "0644"
}
