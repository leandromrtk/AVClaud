provider "azurerm" {
  features {}
}

# Criação do grupo de recursos
resource "azurerm_resource_group" "main" {
  name     = "rg-restaurante"
  location = "East US"
}

# Criação de uma Rede Virtual
resource "azurerm_virtual_network" "main_vnet" {
  name                = "main-vnet"
  address_space        = ["10.0.0.0/16"]
  location            = "East US"
  resource_group_name = azurerm_resource_group.main.name
}

# Criação do App Service Plan
resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "app-service-plan"
  location            = "East US"
  resource_group_name = azurerm_resource_group.main.name
  kind                = "Linux"
  reserved            = true
  sku {
    tier = "Standard"
    size = "S1"
  }
}

# Criação do Web App (para a aplicação)
resource "azurerm_web_app" "restaurant_web_app" {
  name                = "restaurant-web-app"
  location            = "East US"
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id
}

# Criação de um banco de dados SQL
resource "azurerm_sql_server" "sql_server" {
  name                         = "restaurant-sql-server"
  resource_group_name          = azurerm_resource_group.main.name
  location                     = "East US"
  version                      = "12.0"
  administrator_login          = "adminuser"
  administrator_login_password = "Password123!"
}

resource "azurerm_sql_database" "sql_database" {
  name                = "restaurant-db"
  resource_group_name = azurerm_resource_group.main.name
  location            = "East US"
  server_name         = azurerm_sql_server.sql_server.name
  requested_service_objective_name = "S1"
}
