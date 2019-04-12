variable "azure_resource_group_name" {
  description = "Name of the target resource group in Azrue"
  default     = "AzureFunctionVsAwsLambda"
}

variable "azure_subscription_id" {
    description = "Set the target subscription in Azure",
    default = "9c3a833b-ef10-4cb8-8632-57fb4f4c620b"
}

variable "azure_region" {
  description = "Name of the target Azure region"
  default     = "West Europe"
}

variable "aws_region" {
  description = "Name of the target AWS region"
  default     = "eu-west-1"
}