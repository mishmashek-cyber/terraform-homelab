output "created_file_path" {
  description = "Path to the Terraform-managed file"
  value       = local_file.hello.filename
}

output "created_file_id" {
  description = "ID of the Terraform-managed file"
  value       = local_file.hello.id
}

output "created_file_content" {
  description = "Content of the Terraform-managed file"
  value       = local_file.hello.content
}

output "existing_file_content" {
  description = "Content read using a data source"
  value       = data.local_file.existing.content
}
