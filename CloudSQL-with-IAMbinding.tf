resource "google_sql_database_instance" "default" {
  name             = "sql-instance"
  database_version = "MYSQL_8_0"
  region           = "us-central1"

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_project_iam_binding" "sql_admin" {
  project = "my-gcp-project"
  role    = "roles/cloudsql.admin"

  members = [
    "user:admin@example.com"
  ]

  # Explicit dependency
  depends_on = [google_sql_database_instance.default]
}
