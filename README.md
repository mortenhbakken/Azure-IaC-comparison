# Azure-IaC-comparison
Examples of how to solve the following scenario with Infrastructure as Code using the following tools:
- AZ CLI
- ARM Templates
- Bicep
- Terraform
- Pulumi (C#)

# Scenario
- App Service Plan (basic tier, 1 worker)
- Web app with system assigned managed identity
- Storage account with two containers

- Give web app permissions to blob containers via RBAC on the managed identity (only solved in terraform)

All the examples has been developed using Visual Studio Code.
Further instructions on how to set up Visual Studio Code and run the examples locally will be found in the corresponding folders.
