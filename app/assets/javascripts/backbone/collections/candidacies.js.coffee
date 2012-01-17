class window.CandidaciesCollection extends Backbone.Collection
  
  model: CandidacyModel
  
  unselect: ->
    _.each @models, (candidacy) ->
      candidacy.set selected: false
  
  selected: ->
    new CandidaciesCollection _.filter @models, (candidacy) ->
      candidacy.isSelected()
  
  toParam: ->
    namespaces = _.map @selected().models, (candidacy) ->
      candidacy.namespace()
    namespaces.join ','