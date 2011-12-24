class window.PropositionModel extends Backbone.Model
  
  # http://voxe.org/platform/models/proposition
  
  candidacy: ->
    @get "candidacy"
  
  tags: ->
    @get "tags"