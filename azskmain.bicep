targetScope = 'subscription'

param azskLocation string = 'Westeurope'
param azskprefix string = 'aszk'
param azskTags object = {
  Deployd_by: 'Azure StarterKit'
}
param azskEmailForAlert string
param azskBudgetAmount int

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
  scope: resourceGroup(azskRgShared)
  name: 'azskAlerts'
  params: {
    azskLocation: azskLocation
    azsk_budget_amount: azskBudgetAmount
    azsk_rg_shared: azskRgShared
    azsk_email: azskEmailForAlert
  }
}
