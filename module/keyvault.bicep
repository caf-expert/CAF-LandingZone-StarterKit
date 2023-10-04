@description('Name to be used to creates a new key vault.')
param azskKeyVaultName string

@description('region to be used to create a new key vault.')
param azskLocation string

resource keyVault 'Microsoft.KeyVault/vaults@2021-04-01-preview' = {
  name: '${azskKeyVaultName}${uniqueString(resourceGroup().id)}'
  location: azskLocation
  properties: {
    sku: {
      name: 'standard'
      family: 'A'
    }
    tenantId: subscription().tenantId
    accessPolicies: []
    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true
  }
}
