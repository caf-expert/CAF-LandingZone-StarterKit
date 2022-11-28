targetScope = 'subscription'

@description('Name of the resource group to be deployed')
param azskRgName string 

@description('Location of the resource group to be deployed')
param azskLocation string = 'Westeurope'

@description('Tags applied to the resource group been deployed')
param azskTags object 

resource azskRG 'Microsoft.Resources/resourceGroups@2018-05-01' = {
  name: azskRgName
  location: azskLocation
  tags: azskTags
}

output azskRGName string = azskRG.name
