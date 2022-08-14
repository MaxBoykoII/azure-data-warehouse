@description('Specifies the location for resources.')
param location string = resourceGroup().location

@description('Specifies the base prefix for naming resources')
param prefix string

@description('Specifies the administrator user name')
param administratorLogin string

@description('Specifies the administrator password')
@secure()
param administratorLoginPassword string


resource server 'Microsoft.DBForPostgreSql/flexibleServers@2020-02-14-preview' = {
  name: '${prefix}-server'
  location: location
  sku: {
    name: 'Standard_B1ms'
    tier: 'Burstable'
  }

  properties: {
    version: '13'
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    
    storageProfile: {
      storageMB: 32768
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled'
    }
  }

  resource firewallRule1 'firewallRules@2020-02-14-preview' = {
    name: 'AllowAll'
    properties: {
      startIpAddress: '0.0.0.0'
      endIpAddress: '255.255.255.255'
    }
  }

  resource firewallRule2 'firewallRules@2020-02-14-preview' = {
    name: 'AllowAzureServices'
    properties: {
      startIpAddress: '0.0.0.0'
      endIpAddress: '0.0.0.0'
    }
  }

  resource database 'databases@2022-01-20-preview' = {
    name: '${prefix}-oltp-db'
  }

}
