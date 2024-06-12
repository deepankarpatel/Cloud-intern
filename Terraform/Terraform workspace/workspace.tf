provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "myrg" {
  name     = "LoadBalancerRG"
  location = "Central India"
}

resource "azurerm_public_ip" "myip" {
  name                = "PublicIPForLB"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "mylb" {
  name                = lookup(var.lb_names, terraform.workspace)
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.myip.id
  }
}


variable "lb_names" {
    description = "list of loadbalancer names"
    type = map(string)

  default = {
    default = "deafult_lb"
    dev     = "dev_lb"
    prd     = "prd_lb"
  }
}

/*
terraform workspace

  new, list, show, select and delete Terraform workspaces.

Subcommands:
    delete    Delete a workspace
    list      List Workspaces
    new       Create a new workspace
    select    Select a workspace
    show      Show the name of the current workspace

In this code name of loadbalancer changes according to the workspace first you have to create 2 more workspaces
name "dev" or "prd" then if you switched between workspace the name to loadbalancer will change

    */