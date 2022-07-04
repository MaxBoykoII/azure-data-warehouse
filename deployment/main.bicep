@description('Specifies the location for resources.')
param location string

@description('Specifies the base prefix for naming resources')
param prefix string

@description('Specifies whether to integrate with source control')
@allowed([
  'yes'
  'no'
])
param integrateWithSourceControl string = 'no'

@description('Specifies the db administrator login')
param administratorLogin string = 'az_dw_admin'

@description('Specifies the db administrator password')
param administratorLoginPassword string

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

module postgresModule 'azure-postgres-db/azure-postgres-db.bicep' = {
  name: 'oltp-system'
  scope: rg
  params: {
    location: location
    prefix: prefix
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
  }
}
