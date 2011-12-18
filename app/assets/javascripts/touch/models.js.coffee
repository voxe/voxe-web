class window.PropositionModel extends Backbone.Model
  
  # http://voxe.org/platform/models/proposition
  
  candidate: ->
    @get "candidate"
  
  tags: ->
    @get "tags"

class window.TagModel extends Backbone.Model
  
  # http://voxe.org/platform/models/tag
  
  tags: ->
    @get "tags"
  
  name: ->
    @get "name"

class window.CandidateModel extends Backbone.Model
  
  # http://voxe.org/platform/models/candidate
  
  firstName: ->
    @get "firstName"
    
  lastName: ->
    @get "lastName"

class window.ElectionModel extends Backbone.Model
  
  # http://voxe.org/platform/models/election
  
  initialize: ->
    #
  
  name: ->
    @get "name"
  
  candidates: ->
    @get "candidates"
    
  tags: ->
    @get "tags"
  
  toJSON: ->
    object = _.clone(@attributes)
    for key,value of object      
      if value instanceof Backbone.Model
        object[key] = value.toJSON()
    object
  
  parse: (response)->
    response.election
  
  url: ->
    "/api/v1/elections/#{@id}"