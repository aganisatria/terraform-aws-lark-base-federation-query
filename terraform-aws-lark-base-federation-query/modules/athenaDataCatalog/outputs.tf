output "catalog_name" {
  description = "Name of the created Athena Data Catalog."
  value       = aws_athena_data_catalog.this.name
}