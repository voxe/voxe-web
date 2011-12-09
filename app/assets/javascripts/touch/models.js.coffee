class window.ThemeModel extends Backbone.Model

class window.CandidateModel extends Backbone.Model

class window.ElectionModel extends Backbone.Model
  
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