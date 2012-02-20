class window.CandidacyModel extends Backbone.Model
  
  # http://voxe.org/platform/models/candidacy
  
  defaults:
    "selected": false
  
  initialize: ->
    @candidates = new CandidatesCollection(@get 'candidates')

  name: ->
    @candidates.models[0]
  
  namespace: ->
    @get 'namespace'
    
  isSelected: ->
    @get('selected') == true

  urlRoot: "/api/v1/candidacies"

  parse: (response) ->
    response.response.candidacy

  toJSON: ->
    r = super
    r.name = @name()
    r
