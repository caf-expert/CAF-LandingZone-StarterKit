targetScope = 'subscription'

@description('Name of the Budget. It should be unique within a resource group.')
param azskBudgetName string = 'Azure StarterKit Budget'

@description('The total amount of cost or usage to track with the budget')
param azskBudgetAmount int = 150

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

@description('The list of email addresses to send the budget notification to when the threshold is exceeded.')
param azskEmails array

resource budget 'Microsoft.Consumption/budgets@2021-10-01' = {
  name: azskBudgetName
  properties: {
    timePeriod: {
      startDate: azskBudgetStartDate
      endDate: azskBudgetEndDate
    }
    timeGrain: azskTimeGrain
    amount: azskBudgetAmount
    category: 'Cost'
    notifications: {
      NotificationForExceededBudget1: {
        enabled: true
        operator: 'GreaterThan'
        threshold: azskBudgetFirstThreshold
        contactEmails: azskEmails
      }
      NotificationForExceededBudget2: {
        enabled: true
        operator: 'GreaterThan'
        threshold: azskBudgetSecondThreshold
        contactEmails: azskEmails
      }
    }
  }
}
