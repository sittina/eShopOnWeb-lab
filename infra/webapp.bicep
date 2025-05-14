@description('Nom de l’App Service')
param appServiceName string

@description('Région où déployer l’App Service')
param location string

@description('Type de plan App Service')
param sku string = 'F1'

resource plan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: '${appServiceName}-plan'
  location: location
  sku: {
    name: sku
    capacity: 1
  }
  kind: 'app'
}

resource webApp 'Microsoft.Web/sites@2021-03-01' = {
  name: appServiceName
  location: location
  properties: {
    serverFarmId: plan.id
    httpsOnly: true
  }
}
