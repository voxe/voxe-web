class window.CandidatesCollection extends Backbone.Collection
  
  model: CandidateModel

  search: (name) ->
    @fetch {url: "/api/v1/candidates/search", data: {name: name}}

  parse: (response) ->
    response.response.candidates