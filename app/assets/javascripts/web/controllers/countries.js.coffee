@app.controller 'CountriesCtrl', ['$rootScope', 'electionService', ($scope, electionService) ->
  $scope.electionsCountries = {}

  electionService.search().then (elections) ->
    $scope.electionsCountries = elections.reduce(
      (hsh, election) ->
        if countryNamespace = election.country?.namespace
          category = if election.isUpcoming() then 'upcoming' else 'past'
          hsh[category][countryNamespace] ||= election.country
          hsh[category][countryNamespace].elections ||= new Array()
          hsh[category][countryNamespace].elections.push election
        hsh
      { upcoming: {}, past: {} }
    )
]
