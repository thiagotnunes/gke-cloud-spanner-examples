resource "google_spanner_instance" "instance" {
  config           = var.instance_config
  name             = var.instance_id
  display_name     = var.instance_id
  processing_units = var.instance_processing_units
}

resource "google_spanner_database" "database" {
  instance = google_spanner_instance.instance.name
  name     = var.database_id
  ddl = [
    "CREATE TABLE orders(id STRING(MAX) NOT NULL, date DATE NOT NULL, cost NUMERIC NOT NULL, items ARRAY<STRING(MAX)> NOT NULL) PRIMARY KEY(id)",
    "CREATE TABLE products(id STRING(MAX) NOT NULL, name STRING(MAX) NOT NULL, description STRING(MAX) NOT NULL, picture STRING(MAX) NOT NULL, cost NUMERIC NOT NULL, categories ARRAY<STRING(MAX)> NOT NULL) PRIMARY KEY(id)",
  ]
}
