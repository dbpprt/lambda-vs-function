# resource "azurerm_resource_group" "rg" {
#   name     = "${var.azure_resource_group_name}"
#   location = "${var.azure_region}"
# }

# resource "random_string" "storage_name" {
#   length  = 16
#   special = false
#   upper   = false
# }

# resource "random_string" "function_name" {
#   length  = 16
#   special = false
#   upper   = false
# }

# resource "random_string" "app_service_plan_name" {
#   length  = 16
#   special = false
# }

# resource "azurerm_storage_account" "storage" {
#   name                     = "${random_string.storage_name.result}"
#   resource_group_name      = "${azurerm_resource_group.rg.name}"
#   location                 = "${azurerm_resource_group.rg.location}"
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }

# resource "azurerm_storage_container" "storage_container" {
#   name                  = "func"
#   resource_group_name   = "${azurerm_resource_group.rg.name}"
#   storage_account_name  = "${azurerm_storage_account.storage.name}"
#   container_access_type = "private"
# }

# resource "azurerm_storage_blob" "storage_blob" {
#   name                   = "azure.zip"
#   resource_group_name    = "${azurerm_resource_group.rg.name}"
#   storage_account_name   = "${azurerm_storage_account.storage.name}"
#   storage_container_name = "${azurerm_storage_container.storage_container.name}"
#   type                   = "block"
#   source                 = "./dist/azure.zip"
# }

# data "azurerm_storage_account_sas" "storage_sas" {
#   connection_string = "${azurerm_storage_account.storage.primary_connection_string}"
#   https_only        = false

#   resource_types {
#     service   = false
#     container = false
#     object    = true
#   }

#   services {
#     blob  = true
#     queue = false
#     table = false
#     file  = false
#   }

#   start  = "2018-03-21"
#   expiry = "2028-03-21"

#   permissions {
#     read    = true
#     write   = false
#     delete  = false
#     list    = false
#     add     = false
#     create  = false
#     update  = false
#     process = false
#   }
# }

# resource "azurerm_app_service_plan" "plan" {
#   name                = "${random_string.app_service_plan_name.result}"
#   location            = "${azurerm_resource_group.rg.location}"
#   resource_group_name = "${azurerm_resource_group.rg.name}"
#   kind                = "functionapp"

#   sku {
#     tier = "Dynamic"
#     size = "Y1"
#   }
# }

# resource "azurerm_function_app" "function" {
#   name                      = "${random_string.storage_name.result}"
#   location                  = "${azurerm_resource_group.rg.location}"
#   resource_group_name       = "${azurerm_resource_group.rg.name}"
#   app_service_plan_id       = "${azurerm_app_service_plan.plan.id}"
#   storage_connection_string = "${azurerm_storage_account.storage.primary_connection_string}"
#   "version"                 = "~2"

#   app_settings {
#     #"FUNCTIONS_WORKER_RUNTIME" = "dotnet"
#     "FUNCTION_APP_EDIT_MODE"   = "readonly"
#     "https_only"               = true

#     "HASH"                     = "${base64sha256(file("./dist/azure.zip"))}"
#     "WEBSITE_RUN_FROM_PACKAGE" = "https://${azurerm_storage_account.storage.name}.blob.core.windows.net/${azurerm_storage_container.storage_container.name}/${azurerm_storage_blob.storage_blob.name}${data.azurerm_storage_account_sas.storage_sas.sas}"
#   }
# }
