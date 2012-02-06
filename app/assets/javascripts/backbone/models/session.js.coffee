class window.SessionModel extends Backbone.Model
    
  url: ->
    "/api/v1/users/verify"
  
  parse: (response) ->
    response.response.user