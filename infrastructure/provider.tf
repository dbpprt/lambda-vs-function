provider "aws" {
  shared_credentials_file = "$HOME/.aws/credentials"
  profile                 = "default"
  region                  = "${var.aws_region}"
}

provider "azurerm" {
  version = "=1.24.0"
  subscription_id = "${var.azure_subscription_id}"
}

