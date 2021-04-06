# Instructions
Install latest version of [AZ CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) (a recent version is necessary for bicep support)

Install Bicep CLI with the following AZ CLI command: ``az bicep install`` 

This Bicep template is written for resource group deployment. Deploy using the following AZ CLI commands (assuming your shell is in this folder):

``az login``

If you have access to several subscriptions set the correct one as the current context:

``az account set --subscription="<subscription_id>"``

``az group create --name <your resource group name> --location "<your selected region>"``

``az deployment group create --name ExampleDeployment --resource-group <your resource group name> --template-file azuredeploy.bicep --parameters azuredeploy.parameters.demo.json``
