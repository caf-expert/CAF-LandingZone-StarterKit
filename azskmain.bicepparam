// New Parameterfile syntax for bicep code

using './azskmain.bicep'

// Location for the deployment of the starterkit
param azskLocation = 'westeurope'

// Prefix for the deploeyd resources in this starter kit  
param azskprefix = 'azsk'

// Tags for the deployment of the starterkit
param azskTags = {
  Deployed_by: 'Azure Starter Kit'
}

// Name of the Budget
param aszkBudgetName = 'AzureStarterKitBudget'

// Define the granularity of the budget
param azskTimeGrain = 'Monthly'

// Define the email addresses for the budget alert
param azskEmailsForAlert =  [ '<yourname>@mail.com' ]

// Define the amount of the budget
param azskBudgetAmount = 100

// Budget start date in format YYYY-MM-DD must be in future and the first day of the month
param azskBudgetStartDate = '20233-05-01'

// Set the budget end date in format YYYY-MM-DD must be in future 
param azskBudgetEndDate = '2025-06-01'

// Define budget alert first threshold
param azskBudgetFirstThreshold = 80

// Define budget alert second threshold
param azskBudgetSecondThreshold = 100

// Define email address for the action group - Deployment alert
param azskActionGroupEmail =  '<yourname>@mail.com' 


