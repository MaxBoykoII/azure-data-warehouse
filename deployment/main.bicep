@description('Specifies the location for resources.')
param location string = 'westus2'

@description('Specifies the environment abbreviation')
param env string = 'test'

targetScope = 'subscription'

var projectName = 'azdw'
var prefix = '${projectName}-${env}'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${prefix}-rg'
  location: location
}

module dataLakeModule 'data-lake/data-lake.bicep' = {
  name: 'dataLake'
  scope: rg
  params: {
    location: location
    project: projectName
  }
}
