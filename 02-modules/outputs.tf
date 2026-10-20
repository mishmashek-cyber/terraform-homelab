output "server_files" {
  description = "Paths of all generated server files"

  value = {
    for name, server in module.servers :
    name => server.file_path
  }
}
