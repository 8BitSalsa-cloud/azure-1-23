provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "this" {
  name     = "example-resources"
  location = "East US"
}

resource "azurerm_storage_account" "this" {
  name                     = "examplestorageaccount"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "this" {
  name                  = "$web"
  storage_account_name = azurerm_storage_account.this.name
  container_access_type = "blob"
}

resource "azurerm_storage_blob" "this" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = azurerm_storage_container.this.name
  type                   = "Block"
  source                 = "/Volumes/Mac SSD/03-pojekte/aug23/azure-1-23/azure-1-23/html-scss/index.html"  # Hier Dateipfad zur HTML-Datei angeben
}

output "static_website_endpoint" {
  value = azurerm_storage_account.this.primary_web_endpoint
}
