provider "azurerm" {
  features {}
}

module "network-security-group" {
  source  = "Azure/network-security-group/azurerm"
  version = "4.1.0"
  resource_group_name = "MetaArgument"
  # insert the 1 required variable here
}

#this module will create a network security group using module