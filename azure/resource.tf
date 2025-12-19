resource "azurerm_resource_group" "demo" {
  name     = "cisco-raman-terraform-ci-demo-rg"
  location = "East US"

  tags = {
    Project = "Terraform-CI"
    Cloud   = "Azure"
  }
}

