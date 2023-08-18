# Prerequisite:

  ###  Install Azure CLI to authenticate Terraform with your Azure account
---
  -  Ubuntu:  `curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash`
  -  MacOS:  `brew update && brew install azure-cli`

  ###  Install Terraform
---
  MacOS: 
  -  `brew tap hashicorp/tap`
  -  `brew install hashicorp/tap/terraform`
  -  `brew update`
  -  `brew upgrade hashicorp/tap/terraform`
  -  `terraform -help`

Run the following commands:
---
  -  `az login`
  -  `az account show`
  -  `terraform init`
  -  `terraform plan`
  -  `terraform apply`


**Modify variables.tf if neccessary**



