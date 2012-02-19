class window.UserModel extends Backbone.Model
  
  initialize: ->
    @session = new SessionModel()
    @session.bind "change", @sessionChanged, @
    
  sessionChanged: ->
    @set @session.toJSON()
  
  url: ->
    if @token()
      return "/api/v1/users/self?auth_token=#{@token()}"
    if @facebookToken()
      return "/api/v1/users/facebookconnect?facebookToken=#{@facebookToken()}"
    "/api/v1/users"
  
  parse: (response) ->
    response.response.user
    
  facebookToken: ->
    @get "facebookToken"
    
  token: ->
    @get "token"
    
  loggedIn: ->
    if @token()
      return true
    false
    
  logout: ->
    @clear()