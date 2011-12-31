class window.CandidacyModel extends Backbone.Model
  
  # http://voxe.org/platform/models/candidacy
  
  initialize: ->
    @candidates = new CandidatesCollection(@get 'candidates')
