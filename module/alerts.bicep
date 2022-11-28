param azskLocation string = resourceGroup().location
param azskEmail string
param azskRgShared string = 'rg-azsk-shared"'
param azskBudgetAmount int = 150

resource azskactiongroup 'Microsoft.Insights/actionGroups@2018-03-01' = {
  name: 'Mail to ${azskEmail}'
  location: 'Global'
  resourceGroup: azskRgShared
  properties: {
    groupShortName: 'azskactiongroupmail'
    enabled: true
    emailReceivers: [
      {
        name: 'azskactiongroupmail'
        emailAddress: azsk_email 
        useCommonAlertSchema: true
        status: 'Enabled'
      }
    ]
}


resource azskbudget 'Microsoft.Consumption/budgets@2019-10-01' = {
  name: 'azskbudget'
  location: azskLocation
  resourceGroup: azskRgShared
  properties: {
    amount: azskBudgetAmount
    timeGrain: 'Monthly'
    timePeriod: {
      startDate: '2020-01-01'
      endDate: '2021-12-31'
    }
    category: 'Cost'
    notifications: [
      {
        enabled: true
        operator: 'GreaterThan'
        threshold: 75
        contactEmails: [
          azskEmail
        ]
        contactGroups: [
          {
            actionGroupId: azskactiongroup.id
          }
        ]
      }
    ]
  }
}


