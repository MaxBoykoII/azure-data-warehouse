@description('Specifies the location for resources.')
param location string = 'eastus'

@description('Specifies the base prefix for naming resources')
param prefix string = 'azdwudacitydev'

@description('Specifies whether to integrate with source control')
param integrateWithSourceControl bool = false

targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${prefix}-rg'
  location: location
}

module dataLakeModule 'data-lake/data-lake.bicep' = {
  name: 'dataLake'
  scope: rg
  params: {
    location: location
    prefix: prefix
  }
}

module synapseModule 'synapse/synapse.bicep' = {
  name: 'synapse'
  scope: rg
  params: {
    location: location
    prefix: prefix
    storageAccountId: dataLakeModule.outputs.storageAccountId
    accountUrl: dataLakeModule.outputs.storageAccountUrl
    integrateWithSourceControl: integrateWithSourceControl
  }
}
