class window.PropositionModel extends Backbone.Model
  
  # http://voxe.org/platform/models/proposition
  
  candidacy: ->
    @get "candidacy"
  
  candidacies: ->
    @get "candidacies"
  
  tags: ->
    @get "tags"
    
  id: ->
    @get "id"
    
  text: ->
    @get "text"

  url: ->
    "/api/v1/propositions/#{@id}"

  parse: (response) ->
    response.response.proposition
