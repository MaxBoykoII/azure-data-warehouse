@description('Specifies the location for resources.')
param location string = resourceGroup().location

@description('Specifies the base name for resources')
param prefix string

resource storage 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: prefix
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

output storageAccountId string = storage.id
output storageAccountUrl string = 'https://${prefix}.dfs.core.windows.net'
