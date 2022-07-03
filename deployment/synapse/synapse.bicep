@description('Specifies the location for resources.')
param location string = resourceGroup().location

@description('Specifies the base name for resources')
param prefix string

@description('Specifies the id of the data lake storage account')
param storageAccountId string

@description('Specifies the url of the data lake storage account')
param accountUrl string

@description('Specifies the object id of the initial workspace admin')
param initialWorkspaceAdminObjectId string

resource synapseAnalytics 'Microsoft.Synapse/workspaces@2021-06-01' = {
  name: prefix
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
    trustedServiceBypassEnabled: true

  }

  resource workspaceFirewall 'firewallRules@2021-04-01-preview' = {
    name: 'allowAll'
    properties: {
      startIpAddress: '0.0.0.0'
      endIpAddress: '255.255.255.255'
    }
  }
}
