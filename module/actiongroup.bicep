param azskActionGroupName string = 'AzureStarterKitActionGroup'
param azskActionGroupEmail string 


resource azsk_actionGroups_name_resource 'microsoft.insights/actionGroups@2019-06-01' = {
  name: azskActionGroupName
  location: 'Global'
  properties: {
    groupShortName: 'azsk-actgrp'
    enabled: true
    emailReceivers: [
      {
        name: '${azskActionGroupName}-email'
        emailAddress: azskActionGroupEmail
      }
    ]
    smsReceivers: []
    webhookReceivers: []
  }
}

output azsk_actionGroups_name_resource_id string = azsk_actionGroups_name_resource.id

