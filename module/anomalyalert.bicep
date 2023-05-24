targetScope = 'subscription'

@description('Create a scheduled action to detect anomalies in your Azure spend')
param azskAnomalyAlertName string= 'azskAnomalyAlert'

@description('Displaynem of the scheduled action to detect anomalies in your Azure spend')
param azskAnomalyAlertDisplayName string= 'Azure Starter Kit Anomaly Alert'

@description('Email address to send the anomaly alert to')
param azskAnomalyAlertEmail string 

@description('Email subject of the anomaly alert')
param azskAnomalyAlertEmailSubject string = 'Azure Starter Kit - Anomaly Alert detected'

@description('Start date of the anomaly alert - default is today')
param azskAnomalyAlertStartDate string = utcNow('u')

var azskAnomalyAlertEndDate = dateTimeAdd(azskAnomalyAlertStartDate,'P1Y')

resource myAnomalyAlert 'Microsoft.CostManagement/scheduledActions@2022-10-01' = {
  name: azskAnomalyAlertName
  kind: 'InsightAlert'
  properties: {
    displayName: azskAnomalyAlertDisplayName
    notificationEmail: azskAnomalyAlertEmail
    scope: '/subscriptions/${subscription().subscriptionId}'
    notification: {
      subject: azskAnomalyAlertEmailSubject
      to: [
        azskAnomalyAlertEmail
      ]
    }
    status: 'Enabled'
    viewId:  resourceId('Microsoft.CostManagement/views/','ms:DailyAnomalyByResourceGroup')
    schedule: {
      frequency: 'Daily'
      startDate: azskAnomalyAlertStartDate
      endDate: azskAnomalyAlertEndDate
    }
  }
}
