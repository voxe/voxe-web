class window.CandidacyModel extends Backbone.Model
  
  # http://voxe.org/platform/models/candidacy
  
  initialize: ->
    @candidates = new CandidatesCollection(@get 'candidates')

  name: ->
    @candidates.models[0]
  
  namespace: ->
    @get 'namespace'

  urlRoot: "/api/v1/candidacies"

  parse: (response) ->
    response.response.candidacy
