terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

#configure the azure provider
provider "azurerm" {
  features {}
  subscription_id = "049b13a7-2fe7-4559-9eef-2be52342b0a2"
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}

