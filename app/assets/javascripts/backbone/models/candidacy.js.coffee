class window.CandidacyModel extends Backbone.Model
  
  # http://voxe.org/platform/models/candidacy
  
  candidates: ->
    @get "candidates"