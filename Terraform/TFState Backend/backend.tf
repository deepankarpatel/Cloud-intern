terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
    backend "azurerm" {
      resource_group_name  = "StorageTF"
      storage_account_name = "tfstate1507"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
  }

}

provider "azurerm" {
  features {}
}
