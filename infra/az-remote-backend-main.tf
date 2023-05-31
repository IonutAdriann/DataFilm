resource "random_id" "tf_name" {
  byte_length = 4
}

# Define Terraform provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.14.0"
    }
  }
}

# Configure the Azure provider
provider "azurerm" {
  features {}
}

# Create a Resource Group for the Terraform State File
resource "azurerm_resource_group" "state-rg" {
  name     = "${lower(var.project)}-tfstate-rg"
  location = var.location

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    environment = var.environment
  }
}

# Create a Storage Account for the Terraform State File
resource "azurerm_storage_account" "state-sta" {
  depends_on              = [azurerm_resource_group.state-rg]
  name                    = "${lower(var.project)}tf${random_id.tf_name.hex}"
  resource_group_name     = azurerm_resource_group.state-rg.name
  location                = azurerm_resource_group.state-rg.location
  account_kind            = "StorageV2"
  account_tier            = "Standard"
  access_tier             = "Hot"
  account_replication_type = "ZRS"
  enable_https_traffic_only = true

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    environment = var.environment
  }
}

# Create a Storage Container for the Core State File
resource "azurerm_storage_container" "core-container" {
  depends_on            = [azurerm_storage_account.state-sta]
  name                  = "datafilm-tfstate"
  storage_account_name  = azurerm_storage_account.state-sta.name
}