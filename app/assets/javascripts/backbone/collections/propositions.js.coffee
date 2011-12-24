class window.PropositionsCollection extends Backbone.Collection
  
  initialize: ->
    app.models.election.bind 'change', (election) =>
      @electionId = election.id
      
    app.models.tag.bind 'change', (tag) =>
      @tagId = tag.id
  
  model: PropositionModel
  
  url: ->
    "/api/v1/propositions/search"
    
  parse: (response) ->
    response.response.propositions