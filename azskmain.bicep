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


var azskRgShared = 'rg-${azskprefix}-shared'

module azskRGs 'module/resourcegroup.bicep' = {
  name: 'azskRGs'
  params: {
    azskLocation: azskLocation
    azskRgName: azskRgShared
    azskTags: azskTags
    }
}

module azskAlerts 'module/alerts.bicep' = {
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

module azskPolicyInitiative 'module/policyinitiative.bicep' = {
  name: 'azskPolicyInitiative'
}
