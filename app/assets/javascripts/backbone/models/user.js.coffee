class window.UserModel extends Backbone.Model
  
  initialize: ->
    # set session
    @session = new SessionModel(user: @)
  
  url: ->
    if @id
      "/api/v1/users/#{@id}"
    else
      "/api/v1/users"
  
  parse: (response) ->
    response.response.user