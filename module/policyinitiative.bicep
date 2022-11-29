targetScope = 'subscription'

var azskPolicySetName = 'Azure-StarterKist-governance-policy-set'
var azskPolicySetDisplayName = 'Azure Landing Zone Starter Kit - Baisc Governance'
var azskPolicySetDescription = 'Assign the basic policies for Azure Landing Zone Starter Kit'

// Get default policy IDs
var defaultSecurityPolicyIds = json(loadTextContent('./policy-ids-libary/starterkit.json'))

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
        policyDefinitionReferenceId: 'MFA should be enabled for accounts with write permissions on your subscription'
        policyDefinitionId: defaultSecurityPolicyIds.MFAShouldBeEnabledAccountsWithWritePermissionsOnYourSubscription

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
        policyDefinitionReferenceId: 'MFA should be enabled on accounts with owner permissions on your subscription'
        policyDefinitionId: defaultSecurityPolicyIds.MFAShouldBeEnabledOnAccountsWithOwnerPermissionsOnYourSubscription
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
        policyDefinitionReferenceId: 'Subscription should have a contact Email address for security issues'
        policyDefinitionId: defaultSecurityPolicyIds.SubscriptionsShouldHaveAContactEmailAddressForSecurityIssues
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
        policyDefinitionReferenceId: 'A maximum of 3 owners should be designated for your subscription'
        policyDefinitionId: defaultSecurityPolicyIds.AMaximumOf3OwnersShouldBeDesignatedForYourSubscription
        parameters: {
          effect: {
            value: 'AuditIfNotExists'
          }
        }
      }
      {
        groupNames: [
          'Network'
        ]
        policyDefinitionReferenceId: 'All network ports should be restricted on network security groups associated with your VMs'
        policyDefinitionId: defaultSecurityPolicyIds.AllNetworkPortsShouldBeRestrictedOnNetworkSecurityGroupsAssociatedToYourVirtualMachine
        parameters: {
          effect: {
            value: 'AuditIfNotExists'
          }
        }
      }
      {
        groupNames: [
          'Network'
        ]
        policyDefinitionReferenceId: 'Internetfacing VMs should be protected with NSGs'
        policyDefinitionId: defaultSecurityPolicyIds.InternetfacingVirtualMachinesShouldBeProtectedWithNetworkSecurityGroups
        parameters: {
          effect: {
            value: 'AuditIfNotExists'
          }
        }
      }
      {
        groupNames: [
          'Network'
        ]
        policyDefinitionReferenceId: 'Subnets should be associated with NSGs'
        policyDefinitionId: defaultSecurityPolicyIds.SubnetsShouldBeAssociatedWithANetworkSecurityGroup
        parameters: {
          effect: {
            value: 'AuditIfNotExists'
          }
        }
      }
      {
        groupNames: [
          'Network'
        ]
        policyDefinitionReferenceId: 'Network Watcher should be enabled'
        policyDefinitionId: defaultSecurityPolicyIds.NetworkWatcherShouldBeEnabled
        parameters: {
          effect: {
            value: 'AuditIfNotExists'
          }
        }
      }
      {
        groupNames: [
          'Security'
        ]
        policyDefinitionReferenceId: 'System updates should be installed on your machines'
        policyDefinitionId: defaultSecurityPolicyIds.SystemUpdatesShouldBeInstalledOnYourMachines
        parameters: {
          effect: {
            value: 'AuditIfNotExists'
          }
        }
      }
      //TODO: More Policies
    ]
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
