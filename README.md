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

##### Anomaly Alert

In the Azure Cost management there is the option to setup a anomaly alert. With this setup, there will be a mail sended out as soon as Azure Cost Management detect a anomaly in the forecast of the cost. Multiple alerts can be setup in the portal. 
#### Security Baseline

We setup up some basic build-in Azure policies. this is the list of the policies which will be assigned to the subscription. The following tables show the groups and the assigned policies.

##### Identiy and Accessmanagement
|Policy|Descitpion|Referenz|
|---|---|---|

##### Network
|Policy|Descitpion|Referenz|
|---|---|---|

##### Security
|Policy|Descitpion|Referenz|
|---|---|---|


All policies will be collection into a initiative and this will be assigned to the subscription in scope of the deployment. This gives the option to check how good the Azure resources are compliant to these policies in one view.

**TODO - SCREENSHOT**

## Have in mind


## Contributing ##

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit <https://cla.microsoft.com.>

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
