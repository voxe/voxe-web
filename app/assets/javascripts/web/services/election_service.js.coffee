@app.service 'electionService', ['$http', '$q', 'Election', ($http, $q, Election) ->
    search: () ->
      deferred = $q.defer()
      $http.get('/api/v1/elections/search').
        success (data) ->
          deferred.resolve data.response.elections.map((attrs) -> new Election(attrs))
      deferred.promise
    get: (id) ->
      deferred = $q.deffer()
      $http.get("/api/v1/elections/#{id}").
        success (data) ->
          deferred.resolve(new Election(data.response.election))
      deferred.promise
]
