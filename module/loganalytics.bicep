@description('Name of the Log Analytics Workspace')
param azskLogAnalyticsName string

@description('Location of the Log Analytics Workspace')
param azskLogAnalyticsLocation string = resourceGroup().location

@description('Tags to be used for Log Analytics Workspace')
param azskTags object = {}

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: azskLogAnalyticsName
  location: azskLogAnalyticsLocation
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
  }
  tags: azskTags
}
