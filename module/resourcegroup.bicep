targetScope = 'subscription'

param azskRgName string 
param azskLocation string = 'Westeurope'
param azskTags object 

resource azskRG 'Microsoft.Resources/resourceGroups@2018-05-01' = {
  name: azskRgName
  location: azskLocation
  tags: azskTags
}
