class window.CandidateModel extends Backbone.Model
  
  # http://voxe.org/platform/models/candidate
  
  firstName: ->
    @get "firstName"
    
  lastName: ->
    @get "lastName"

  toString: ->
    "#{@get 'firstName'} #{@get 'lastName'}"
