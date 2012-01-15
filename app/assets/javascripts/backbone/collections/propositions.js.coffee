class window.PropositionsCollection extends Backbone.Collection
  
  model: PropositionModel
  
  url: ->
    "/api/v1/propositions/search"
    
  parse: (response) ->
    response.response.propositions
