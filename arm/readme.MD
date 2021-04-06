# Instructions
This ARM template is written for resource group deployment. Deploy using the following AZ CLI commands (assuming your shell is in this folder):

``az group create --name <your resource group name> --location "<your selected region>"``

``az deployment group create --name ExampleDeployment --resource-group <your resource group name> --template-file azuredeploy.json --parameters azuredeploy.parameters.json``
