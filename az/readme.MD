# Instructions

Install latest version of [AZ CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

Open a bash terminal (on windows you get it by installing git, enable it in VS Code by following these [instructions](https://stackoverflow.com/questions/42606837/how-do-i-use-bash-on-windows-from-the-visual-studio-code-integrated-terminal))

Run the following commands:

``az login``

If you have access to several subscriptions set the correct one as the current context:

``az account set --subscription="<subscription_id>"``

Run the shell script like this (exchange the command line parameters with your own values. Remember that app service name and storage account name must be unique): 

``./azdeploy.sh <location> <resource group name> <app service plan name> <app service name> <storage account name>``
