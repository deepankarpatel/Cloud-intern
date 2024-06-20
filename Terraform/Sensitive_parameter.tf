provider "azurerm" {
  features {
    
  }
}

locals {
  db_password = {
    admin = "password"
  }
}

output "db_password" {
  value = local.db_password
  sensitive = true
}

#the password is sensitive parameter is here without sensitive arguement the password is shown in cli
# with sensitive parameter arguement the passrord is hidden in cli
