@description('Specifies the location for resources.')
param location string = resourceGroup().location

@description('Specifies the base name for resources')
param project string

@description('Specifies the id of the data lake storage account')
param storageAccountId string

@description('Specifies the url of the data lake storage account')
param accountUrl string

@description('Specifies the object id of the initial workspace admin')
param initialWorkspaceAdminObjectId string

resource synapseAnalytics 'Microsoft.Synapse/workspaces@2021-06-01' = {
  name: project
  location: location

  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    defaultDataLakeStorage: {
      filesystem: 'datalakefiles'
      accountUrl: accountUrl
      resourceId: storageAccountId
      createManagedPrivateEndpoint: false
    }
    publicNetworkAccess: 'Enabled'
    cspWorkspaceAdminProperties: {
      initialWorkspaceAdminObjectId: initialWorkspaceAdminObjectId
    }
    azureADOnlyAuthentication: false
    trustedServiceBypassEnabled: false
  }
}
