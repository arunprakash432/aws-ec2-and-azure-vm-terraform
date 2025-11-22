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
  subscription_id = "subscription-id"
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}

