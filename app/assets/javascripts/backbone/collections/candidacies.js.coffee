class window.CandidaciesCollection extends Backbone.Collection
  
  model: CandidacyModel
  
  toParam: ->
    namespaces = _.map @models, (candidacy) ->
      candidacy.namespace()
    namespaces.join ','