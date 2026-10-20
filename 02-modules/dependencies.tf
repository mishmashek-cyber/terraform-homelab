resource "local_file" "database_config" {
  filename        = "${path.root}/database.conf"
  content         = "Database configuration ready"
  file_permission = "0644"

  lifecycle {
    prevent_destroy = true
  }
}

resource "local_file" "application_config" {
  filename        = "${path.root}/application.conf"
  content         = "Application depends on database"
  file_permission = "0644"

  depends_on = [local_file.database_config]
}

resource "local_file" "lifecycle_test" {
  filename        = "${path.root}/lifecycle-test.txt"
  content         = "Version 1"
  file_permission = "0644"

  lifecycle {
    create_before_destroy = true
  }
}
resource "local_file" "ignore_test" {
  filename        = "${path.root}/ignore-test.txt"
  content         = "Modified content"
  file_permission = "0644"

  lifecycle {
    ignore_changes = [content]
  }
}
