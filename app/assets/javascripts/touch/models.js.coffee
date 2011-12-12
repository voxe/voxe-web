class window.PropositionModel extends Backbone.Model
  
  candidate: ->
    @get "candidate"
  
  theme: ->
    @get "theme"

class window.ThemeModel extends Backbone.Model
  
  themes: ->
    @get "themes"
  
  name: ->
    @get "name"

class window.CandidateModel extends Backbone.Model
  
  name: ->
    @get "name"

class window.ElectionModel extends Backbone.Model
  
  initialize: ->
    #
  
  name: ->
    @get "name"
  
  candidates: ->
    @get "candidates"
    
  themes: ->
    @get "themes"
  
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