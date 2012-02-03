class window.SessionModel extends Backbone.Model
  
  defaults:
    "auth_token": "Mh5tB2eSNqyqpCkZ91nT"
  
  initialize: (options)->
    # 
    @user = options.user
  
  url: ->
    "/api/v1/users/signin"
  
  parse: (response) ->
    response.response
    
  email: ->
    @get 'email'
    
  authToken: ->
    @get 'auth_token'