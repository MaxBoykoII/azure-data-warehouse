@description('Specifies the location for resources.')
param location string = resourceGroup().location

@description('Specifies the base name for resources')
param prefix string

@description('Specifies the id of the data lake storage account')
param storageAccountId string

@description('Specifies the url of the data lake storage account')
param accountUrl string

@description('Specifies whether to integrate with source control')
@allowed([
  'yes'
  'no'
])
param integrateWithSourceControl string = 'no'

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

    azureADOnlyAuthentication: false
    trustedServiceBypassEnabled: true

    workspaceRepositoryConfiguration: (integrateWithSourceControl == 'yes') ? {
      accountName: 'MaxBoykoII'
      collaborationBranch: 'main'
      type: 'WorkspaceGitHubConfiguration'
      rootFolder: '/artifacts'
      repositoryName: 'azure-data-warehouse'
    } : {}
  }

  resource workspaceFirewall 'firewallRules@2021-04-01-preview' = {
    name: 'allowAll'
    properties: {
      startIpAddress: '0.0.0.0'
      endIpAddress: '255.255.255.255'
    }
  }

  resource dedicatedPool 'sqlPools@2021-06-01' = {
    name: 'bikesharepool'
    sku:  {
      name: 'DW100c'
    }
    location: location
    properties: {
      collation: 'SQL_Latin1_General_CP1_CI_AS'
    }
  }
}
