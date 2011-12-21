# COLLECTIONS

class window.PropositionsCollection extends Backbone.Collection
  
  candidateIds: ->
    ids = _.map app.collections.selectedCandidates.models, (candidate) ->
      candidate.id
    ids.join ','
  
  initialize: ->
    app.models.election.bind 'change', (election) =>
      @electionId = election.id
      
    app.models.tag.bind 'change', (tag) =>
      @tagId = tag.id
  
  model: PropositionModel
  
  url: ->
    "/api/v1/propositions/search?electionIds=#{@electionId}&tagIds=#{@tagId}&candidateIds=#{@candidateIds()}"
    
  parse: (response) ->
    response.propositions
  

class window.CandidatesCollection extends Backbone.Collection
  
  model: CandidateModel