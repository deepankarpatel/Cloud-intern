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


#in this code we mention the provider and backend for storing the tf.state file to storage account
#in this we given the details of our storage account and our container 
# !!Note
# first you have to create a storage acount then give the info of storage account in backend 