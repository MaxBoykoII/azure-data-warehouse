@description('Specifies the location for resources.')
param location string = 'westus2'

targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'az-dw-test'
  location: location
}
