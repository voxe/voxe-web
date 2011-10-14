class window.CandidateModel extends Backbone.Model
  
  urlRoot: '/api/v1/candidates'
  
  toJSON: ->
    object = _.clone(@attributes)
    for key,value of object      
      if value instanceof Backbone.Model
        object[key] = value.toJSON()
    object
    
  parse: (response)->
    response.candidate