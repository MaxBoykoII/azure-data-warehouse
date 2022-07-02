@description('Specifies the location for resources.')
param location string = resourceGroup().location

@description('Specifies the prefix for naming resources')
param prefix string

resource storage 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: '${prefix}-storage'
  kind: 'StorageV2'
  location: location
  sku: {
    name: 'Standard_LRS'
  }

  properties: {
  accessTier: 'Hot'
  isHnsEnabled: true
  }
}
