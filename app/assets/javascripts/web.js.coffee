#= require hamlcoffee
#= require angularjs/angular-1.0.6
#= require angularjs/angular-ui-states
#= require i18n
#= require i18n/translations
#= require_tree ./web/templates
#= require_self
#= require_tree ./web

@app = angular.module('voxe', ['ui.compat'])
@app.config ['$stateProvider', '$locationProvider', ($stateProvider, $locationProvider) ->
  $locationProvider.html5Mode true
  $stateProvider.state('countries',
    url: '/'
    views:
      countries:
        template: JST['web/templates/countries']()
        controller: 'CountriesCtrl'
  ).state('countries.elections',
    url: 'country-:countryId'
    views:
      'elections@':
        template: JST['web/templates/elections']()
        controller: 'ElectionsCtrl'
  )
]
