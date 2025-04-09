output "web_app_url" {
  value = azurerm_web_app.restaurant_web_app.default_site_hostname
}

output "sql_database_connection_string" {
  value = azurerm_sql_database.sql_database.connection_string
}
