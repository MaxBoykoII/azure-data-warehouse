@description('Specifies the location for resources.')
param location string = resourceGroup().location

@description('Specifies the base name for resources')
param project string

@description('Specifies the id of the data lake storage account')
param storageAccountId string

resource synapseAnalytics 'Microsoft.Synapse/workspaces@2021-06-01' = {
  name: project
  location: location

  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    defaultDataLakeStorage: {
      filesystem: 'datalakefiles'
      resourceId: storageAccountId
      createManagedPrivateEndpoint: false
    }
  }
}
