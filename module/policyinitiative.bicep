targetScope = 'subscription'

param azskpolicy1 string = 'provider/Microsoft.Authorization/policyDefinitions/9297c21d-2ed6-4474-b48f-163f75654ce3'
param azskpolicy2 string = 'provider/Microsoft.Authorization/policyDefinitions/aa633080-8b72-40c4-a2d7-d00c03e80bed'

var azskPolicySetName = 'Azure-StarterKist-governance-policy-set'
var azskPolicySetDisplayName = 'Azure Landing Zone Starter Kit - Baisc Governance'
var azskPolicySetDescription = 'Assign the basic policies for Azure Landing Zone Starter Kit'

// Policy initiative definition  

resource azskPolicySet 'Microsoft.Authorization/policySetDefinitions@2019-09-01' = {
  name: azskPolicySetName
  properties: {
    displayName: azskPolicySetDisplayName
    description: azskPolicySetDescription
    policyType: 'Custom'
    metadata: {
      category: 'Landing Zone'
    }
    policyDefinitionGroups: [
      {
        category: 'Governance'
        name: 'IAM'
        displayName: 'Identity and Access Management'
      }
      {
        category: 'Governance'
        name: 'Network'
        displayName: 'Network'
      }
      {
        category: 'Governance'
        name: 'Security'
        displayName: 'Security'
      }
      {
        category: 'Governance'
        name: 'Cost'
        displayName: 'Cost'
      }
    ]
    policyDefinitions: [
      {
        groupNames: [
          'IAM'
        ]
        policyDefinitionReferenceId: 'MFA should be enabled for accounts with write permissions on your subscription_1'
        policyDefinitionId: azskpolicy1
        parameters: {
          effect: {
            value: 'AuditIfNotExists'
          }
        }
      }
      {
        groupNames: [
          'IAM'
        ]
        policyDefinitionReferenceId: 'MFA should be enabled on accounts with owner permissions on your subscription_1'
        policyDefinitionId: azskpolicy2
        parameters: {
          effect: {
            value: 'AuditIfNotExists'
          }
        }
      }
    ]
  }
}
