class window.UserModel extends Backbone.Model
  
  initialize: ->
    @session = new SessionModel()
    @session.bind "change", @sessionChanged, @
    
  sessionChanged: ->
    @set @session.toJSON()
  
  url: ->
    if @token()
      return "/api/v1/users/self?auth_token=#{@token()}"
    "/api/v1/users"
  
  parse: (response) ->
    response.response.user
    
  token: ->
    @get "token"
    
  loggedIn: ->
    if @token()
      return true
    false