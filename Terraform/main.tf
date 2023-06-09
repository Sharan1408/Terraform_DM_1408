# Define Terraform provider
terraform {
required_version = ">= 0.12" 
}# Configure the Azure provider 
provider "azurerm" {
environment = "public" 
version = ">= 2.0.0" 
features {}
}# Create a resource group for network
resource "azurerm_resource_group" "network-rg" {
     name = "${var.app_name}-${var.environment}-rg"
location = var.location 
tags = {
application = var.app_name
environment = var.environment }
}# Create the network VNET
resource "azurerm_virtual_network" "network-vnet" {
name = "${var.app_name}-${var.environment}-vnet" 
address_space = [var.network-vnet-cidr]
resource_group_name = azurerm_resource_group.network-rg.name 
location = azurerm_resource_group.network-rg.location
tags = {
application = var.app_name 
environment = var.environment
}
}# Create a subnet for Network
resource "azurerm_subnet" "network-subnet" {
name = "${var.app_name}-${var.environment}-subnet" 
address_prefix = var.network-subnet-cidr
virtual_network_name = azurerm_virtual_network.network-vnet.name
 resource_group_name = azurerm_resource_group.network-rg.name
}