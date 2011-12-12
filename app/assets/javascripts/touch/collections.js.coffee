# COLLECTIONS

class window.PropositionsCollection extends Backbone.Collection
  
  candidateIds: ->
    ids = _.map app.collections.selectedCandidates.models, (candidate) ->
      candidate.id
    ids.join ','
  
  initialize: ->
    app.models.election.bind 'change', (election) =>
      @electionId = election.id
      
    app.models.theme.bind 'change', (theme) =>
      @themeId = theme.id
  
  model: PropositionModel
  
  url: ->
    "/api/v1/propositions/search?electionId=#{@electionId}&themeId=#{@themeId}&candidateIds=#{@candidateIds()}"
    
  parse: (response) ->
    response.propositions
  

class window.CandidatesCollection extends Backbone.Collection
  
  model: CandidateModel