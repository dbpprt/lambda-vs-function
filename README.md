# AWS Lambda vs. Azure Functions
## Who has better cold-start performance?

This repository contains the following components:
* Azure Function /azure
* AWS Lambda /aws
* Terraform files to provision the infrastructure
* Build script ./build.ps1 

I'm actually interested to compare the cold-start performance between both products. Startup time is actually the most critical factor when deciding to go "serverless".

## How to run it
Make sure you have the following tools installed:
* AWS CLI (please log-in)
* Azure CLI (please log-in)
* Terraform
* .NET Core SDK 2.2
* Powershell Core to run the build script

```
pwsh build.ps1
terraform apply ./infrastructure/
```
