terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0, < 4.0"
    }
  }
}

provider "azurerm" {
  features {}
 subscription_id = secret.AZURE_SUBSCRIPTION_ID
  client_id       = secrets.AZURE_AD_CLIENT_ID
  client_secret   = secrets.AZURE_AD_CLIENT_SECRET
  tenant_id       = secrets.AZURE_AD_TENENT_ID

}
