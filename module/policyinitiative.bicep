targetScope = 'subscription'

var azskPolicySetName = 'Azure-StarterKist-governance-policy-set'
var azskPolicySetDisplayName = 'Azure Landing Zone Starter Kit - Baisc Governance'
var azskPolicySetDescription = 'Assign the basic policies for Azure Landing Zone Starter Kit'

// Get default policy IDs
var defaultPolicyGroups = array(json(loadTextContent('./policy-ids-libary/azskpolicygroups.json')))
var defaultSecurityPolicies = array(json(loadTextContent('./policy-ids-libary/azskpolicydefinitions.json')))

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
    policyDefinitionGroups: [for definitiongroup in defaultPolicyGroups:{
      category: definitiongroup.category
      name: definitiongroup.name
      displayName: definitiongroup.displayName
    }]
    policyDefinitions: [for defaultpolicy in defaultSecurityPolicies: {
        groupNames: [
          defaultpolicy.policyGroup
        ]
        policyDefinitionReferenceId: defaultpolicy.policyDefinitionReferenceId
        policyDefinitionId: defaultpolicy.policyDefinitionId
        parameters: {
          effect: {
            value: defaultpolicy.effectValue
          }
        }
      }]
  }
}

// Assign policy set to subscription
resource azskPolicyAssignment 'Microsoft.Authorization/policyassignments@2016-04-01' = {
  name: '${azskPolicySetName}-assignment'
  properties: {
    displayName: azskPolicySetDisplayName
    policyDefinitionId: azskPolicySet.id
    scope: subscription().id

  }
}
