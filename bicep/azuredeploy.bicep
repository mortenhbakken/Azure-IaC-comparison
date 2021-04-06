param servicePlanName string
param appServiceName string
param storageAccName string
param location string = resourceGroup().location

resource appServicePlan 'Microsoft.Web/serverfarms@2020-10-01' = {
  name: servicePlanName
  location: location
  sku: {
    name: 'B1'
    capacity: 1
  }
}

resource appService 'Microsoft.Web/sites@2020-10-01' = {
  name: appServiceName
  location: location
  kind: 'app'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      windowsFxVersion: '4.0'
    }
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-01-01' = {
  name: storageAccName
  location: location
  kind: 'StorageV2'
  sku:{
    name:'Standard_LRS'
  }
}

resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-01-01' = [for i in range (1,2): {
  name: '${storageAccount.name}/default/container${i}'
}]
