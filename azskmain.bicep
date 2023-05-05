targetScope = 'subscription'

@description('Default location for this deployment')
param azskLocation string = 'Westeurope'

@description('Prefix to be used for resource names')
param azskprefix string = 'aszk'

@description('Tags to be applied to all resources')
param azskTags object = {
  Deployd_by: 'Azure Starter Kit'
}

@description('Name of the Budget. It should be unique within a resource group.')
param aszkBudgetName string = 'AzureStarterKitBudget'

@description('The list of email addresses to send the budget notification to when the threshold is exceeded.')
param azskEmailsForAlert array

@description('Theemail addresses to send the alert to out of the action group.')
param azskActionGroupEmail string

@description('The total amount of cost or usage to track with the budget')
param azskBudgetAmount int

@description('The time covered by a budget. Tracking of the amount will be reset based on the time grain.')
@allowed([
  'Monthly'
  'Quarterly'
  'Annually'
])
param azskTimeGrain string = 'Monthly'

@description('The start date must be first of the month in YYYY-MM-DD format. Future start date should not be more than three months. Past start date should be selected within the timegrain preiod.')
param azskBudgetStartDate string

@description('The end date for the budget in YYYY-MM-DD format. If not provided, we default this to 10 years from the start date.')
param azskBudgetEndDate string

@description('Threshold value associated with a notification. Notification is sent when the cost exceeded the threshold. It is always percent and has to be between 0.01 and 1000.')
param azskBudgetFirstThreshold int = 80

@description('Threshold value associated with a notification. Notification is sent when the cost exceeded the threshold. It is always percent and has to be between 0.01 and 1000.')
param azskBudgetSecondThreshold int = 100

@description('The email address to send the anomaly alert to out of the action group.')
param azskAnomalyAlertEmail string 

@description('The display name of the anomaly alert.')
param azskAnomalyAlertDisplayName string = 'Azure Starter Kit Anomaly Alert'

@description('The name of the anomaly alert.')
param azskAnomalyAlertName string = '${azskprefix}AnomalyAlert'

@description('The subject of the anomaly alert email.')
param azskAnomalyAlertEmailSubject string = 'Azure Starter Kit - Anomaly Alert detected'

var azskRgShared = 'rg-${azskprefix}-shared'

module azskRGs 'module/resourcegroup.bicep' = {
  name: 'azskRGs'
  params: {
    azskLocation: azskLocation
    azskRgName: azskRgShared
    azskTags: azskTags
    }
}
// TODO: Deploy the KeyVault, LogAnalytics and StorageAccount

module azskActionGroup 'module/actiongroup.bicep' = {
  name: 'azskActionGroup'
  scope: resourceGroup(azskRgShared)
  params: {
    azskActionGroupName: 'AzureStarterKitActionGroup'
    azskActionGroupEmail: azskActionGroupEmail
    }
}

module azskAlerts 'module/budgetalert.bicep' = {
  name: 'azskBudgetAlerts'
  params: {
    azskBudgetName: aszkBudgetName
    azskBudgetAmount: azskBudgetAmount
    azskBudgetEndDate: azskBudgetEndDate
    azskBudgetStartDate: azskBudgetStartDate
    azskBudgetFirstThreshold: azskBudgetFirstThreshold
    azskBudgetSecondThreshold: azskBudgetSecondThreshold
    azskEmails: azskEmailsForAlert
    azskTimeGrain: azskTimeGrain
  }
}

module azskActivityLogAlert 'module/activitylogalerts.bicep' = {
  scope : resourceGroup(azskRgShared)
  name: '${azskprefix}ActivityLogAlert'
  params: {
   azskTags: azskTags
   azskActionGroup: azskActionGroup.outputs.azsk_actionGroups_name_resource_id
  }
}

module azskAnomalyAlert 'module/anomalyalert.bicep' = {
  name: '${azskprefix}AnomlayAlert'
  params: {
    azskAnomalyAlertDisplayName: azskAnomalyAlertDisplayName
    azskAnomalyAlertName: azskAnomalyAlertName
    azskAnomalyAlertEmail: azskAnomalyAlertEmail
    azskAnomalyAlertEmailSubject: azskAnomalyAlertEmailSubject
  }
}
module azskPolicyInitiative 'module/policyinitiative.bicep' = {
  name: 'azskPolicyInitiative'
}
