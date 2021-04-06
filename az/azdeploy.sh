#!/bin/bash
location=$1
resourceGroupName=$2
appServicePlanName=$3
appServiceName=$4
storageAccountName=$5

az group create -l $location -n $resourceGroupName
az appservice plan create -g $resourceGroupName -n $appServicePlanName --sku B1 --number-of-workers 1
az webapp create -g $resourceGroupName -p $appServicePlanName -n $appServiceName --assign-identity '[system]' --runtime "aspnet|V4.8"
az storage account create -g $resourceGroupName -n $storageAccountName --kind "StorageV2" --sku "Standard_LRS"
az storage container create -n "container1" --account-name $storageAccountName
az storage container create -n "container2" --account-name $storageAccountName