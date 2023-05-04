
param azskTags object
param azskActionGroup string

resource azskActivyLogAlertDeployment 'Microsoft.Insights/activityLogAlerts@2020-10-01' = {
  name: 'azskActivyLogAlertDeployment'  
  location: 'global'
  tags: azskTags
  properties: {
    scopes: [
      '/subscriptions/${subscription().subscriptionId}'
    ]
    condition: {
      allOf: [
        {
          field: 'category'
          equals: 'Administrative'
        }
        {
          field: 'operationName'
          equals: 'Microsoft.Resources/deployments/write'
        }
        {
          field: 'status'
          containsAny: [
            'succeeded'
          ]
        }
      ]
    }
    actions: {
      actionGroups: [
        {
        actionGroupId: azskActionGroup
        webhookProperties: {
          title: 'AzSK Deployment Alert'
          message: 'AzSK Deployment Alert'
        }
        }
      ]
      }
      description: 'Send mail if a deployment was created and successfully finished'
      enabled: true
    }
}

