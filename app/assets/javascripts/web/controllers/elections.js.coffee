@app.controller 'ElectionsCtrl', ['$rootScope', '$stateParams', ($scope, $stateParams) ->
  $scope.$watch 'electionsCountries', (electionsCountries) ->
    if electionsCountries.upcoming
      $scope.elections = Object.keys($scope.electionsCountries).reduce(
        (elections, category) ->
          countries = $scope.electionsCountries[category]
          if country = countries[$stateParams.countryId]
            country.elections.forEach (election) ->
              elections.push election
          elections
        new Array()
      )
]
