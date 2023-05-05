# CAF-LandingZone-StarterKit

## Why Landing Zone StarterKit

There are a lot of subscription out there in Azure where a basic governance is missing. The intend of the repo is to provide some basic governance settings for a subscription. This is not a substitution of a well design Azure Landing Zone. If you are willing to start the journey to a Azure Landing Zone please refere this [article in the Cloud Adoption Framework(CAF)](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/).

If you do not start with the Lannding Zone based on CAF - this respository will help you to deploy some basics to have a minimum governance in place. 

### Cloud governance disciplins

Five Disciplines of Cloud Governance: 

These disciplines support the corporate policies. Each discipline protects the company from potential pitfalls:

- Cost Management discipline
- Security Baseline discipline
- Resource Consistency discipline
- Identity Baseline discipline
- Deployment Acceleration discipline

This starter kit helps to setup the basics for Cost Management, Security and Identity.

#### Cost Management

The minimum action to be taken in a scope of a subscription in Azure is, that two basic alerts should be setup in Azure Cost Management. One is for the detection of a set budget and the other one is to detect anomalies in the comsumption.

##### Set up the budget alert

This repository offers a module to deploy the budget alert. The parameters for this alert are all set in the azskmain.parameters.json file in the root of the repository. The following parameters must be set:


|Parameter|Descitpion|Default Value|
|---|---|---|
|azskBudgetname|The user friendly name of the budget alert|'Azure StarterKit Budget'|
|azskBudgetAmount|The budget value to test against. You define the amount of money you want to define, where the alert should react on. If you set it to 150 the alert will be notified as soon the Spend reaches the percentage of primary and secondary threshold|150|
|azskEmailsForAlert|Emailadress to send the alert to|no default|
|azskBudgetStartDate|The startdate to test the aktual cost against the budget limit.|'2022-12-01'|
|azskBudgetEndDate|The enddate of this cost vs. budet test.|'2025-12-01|
|azskBudgetFirstThreshold|If this percentage threshold is reached the firt alert will be send out|80|
|azskBudgetSecondThreshold|the second percentage threshold to fire the alert|100|

##### Anomaly Alert

In the Azure Cost management there is the option to setup a anomaly alert. With this setup, there will be a mail sended out as soon as Azure Cost Management detect a anomaly in the forecast of the cost. Multiple alerts can be setup in the portal. 
#### Security Baseline

We setup up some basic build-in Azure policies. this is the list of the policies which will be assigned to the subscription. The following tables show the groups and the assigned policies.

##### Identiy and Accessmanagement
|Policy|Descitpion|Referenz|
|---|---|---|
|Subscription should have a contact Email address for security issues|To ensure the relevant people in your organization are notified when there is a potential security breach in one of your subscriptions, set a security contact to receive email notifications from Security Center.|[Definition](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Azure%20Government/Security%20Center/ASC_Security_contact_email.json)|
|A maximum of 3 owners should be designated for your subscription|It is recommended to designate up to 3 subscription owners in order to reduce the potential for breach by a compromised owner|[Definition](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Azure%20Government/Security%20Center/ASC_DesignateLessThanXOwners_Audit.json)|

##### Network
|Policy|Descitpion|Referenz|
|---|---|---|
|All network ports should be restricted on network security groups associated with your VMs|All network ports should be restricted on network security groups associated to your virtual machine|[Definition](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Azure%20Government/Security%20Center/ASC_UnprotectedEndpoints_Audit.json)|
|nternetfacing VMs should be protected with NSGs'|Protect your virtual machines from potential threats by restricting access to them with network security groups (NSG). Learn more about controlling traffic with NSGs at [https://aka.ms/nsg-doc](https://aka.ms/nsg-doc)|[Definition](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Azure%20Government/Security%20Center/ASC_NetworkSecurityGroupsOnInternetFacingVirtualMachines_Audit.json)|
|Subnets should be associated with a Network Security Group|Protect your subnet from potential threats by restricting access to it with a Network Security Group (NSG). NSGs contain a list of Access Control List (ACL) rules that allow or deny network traffic to your subnet.|[Definition](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Azure%20Government/Security%20Center/ASC_NetworkSecurityGroupsOnSubnets_Audit.json)|
|Network Watcher should be enabled|Network Watcher is a regional service that enables you to monitor and diagnose conditions at a network scenario level in, to, and from Azure. Scenario level monitoring enables you to diagnose problems at an end to end network level view. It is required to have a network watcher resource group to be created in every region where a virtual network is present. An alert is enabled if a network watcher resource group is not available in a particular region.|[Defintion](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Network/NetworkWatcher_Enabled_Audit.json)|

##### Security
|Policy|Descitpion|Referenz|
|---|---|---|
|System updates should be installed on your machines|Missing security system updates on your servers will be monitored by Azure Security Center as recommendations|[Definition](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Azure%20Government/Security%20Center/ASC_MissingSystemUpdates_Audit.json)|

All policies will be collection into a initiative and this will be assigned to the subscription in scope of the deployment. This gives the option to check how good the Azure resources are compliant to these policies in one view.

![Azure Policy compliance view](/media/AuditReport.png)

## How to deploy

To deploy this Starter Kit to a new or already existing subscription just follow these steps:

1. Ensure to be loged into Azure

    ```azurecli
    az login
    ```

2. Select the right Subscrition

    ```azurecli
    az account show --output table
    ```

    Check the output for the subscription which should be used and run the following comamnd to set your specific ID

    ```azurecli
    $subscriptionID = "your subscription ID"
    ``` 

    Set the account to use the susbcription

    ```azurecli
    az account set --subscription $subscriptionID
    ```

3. In the next step you can choose between to option:

- Create a new deployment at Suscription level with the classic **.json parameter file** to deploy the Starter Kit

    ```azurecli
    $location = "your preferred location"
    
    az deployment sub create --location $location --template-file "azskmain.bicep" --parameters "azskmain.parameters.json" --confirm-with-what-if
    
    ```

- Create a new deployment at Suscription level with the new **.bicepparam parameter file** to deploy the Starter Kit

    To do this, you need to create a new bicep file with the name azskmain.bicepparam to define the parameters for the deployment. To use this kind of files you need to have the following versions on your system:

  - Azure CLI 2.48.1 or later (check with az --version)
  - Bicep version 0.16.2 or later (chekc with az bicep --version)
  - and you have to configure your bicepconfig.json (see repo for an example)

    ```azurecli
    $location = "your preferred location"
    
    az deployment sub create --location $location --template-file "azskmain.bicep" --parameters "azskmain.bicepparam" --confirm-with-what-if

    ```
  
## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit <https://cla.microsoft.com.>

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
