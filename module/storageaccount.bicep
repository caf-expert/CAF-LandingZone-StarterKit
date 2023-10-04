@description('Creates a storage account with the specified name.')
param azskStorageAccountName string

@description('The location of the storage account.')
param azskLocation string

@description('The SKU name of the storage account.')
param azskSkuName string = 'Standard_LRS'

@description('The tags to associate with the storage account.')
param azskTags object

resource azskStorageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: '${azskStorageAccountName}${uniqueString(resourceGroup().id)}'
  location: azskLocation
  sku: {
    name: azskSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
    }
  }
  tags: azskTags
}
