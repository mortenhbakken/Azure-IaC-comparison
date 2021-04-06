provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-resources"
  location = var.location
}

resource "azurerm_app_service_plan" "main" {
  name                = "${var.prefix}-asp"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "main" {
  name                = "${var.prefix}-appservice"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = azurerm_app_service_plan.main.id

  site_config {
    dotnet_framework_version  = "v4.0"
    min_tls_version           = "1.2"
    always_on                 = true
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_storage_account" "main" {
  name                      = "${var.prefix}storage"
  resource_group_name       = azurerm_resource_group.main.name
  location                  = azurerm_resource_group.main.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
}

variable "container_names" {
  description = "Create these named blob containers"
  type = list(string)
  default = ["container1", "container2"]
}

resource "azurerm_storage_container" "containers" {
  count = length(var.container_names)
  name = var.container_names[count.index]
  storage_account_name    = azurerm_storage_account.main.name
}

resource "azurerm_role_assignment" "main" {
  role_definition_name  = "Storage Blob Data Reader"
  scope                 = azurerm_storage_account.main.id
  principal_id          = azurerm_app_service.main.identity[0].principal_id
}
