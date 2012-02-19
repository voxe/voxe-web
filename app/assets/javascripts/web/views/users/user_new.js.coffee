class window.UserNewView extends Backbone.View
  
  initialize: (options)->
    @model.bind 'error', @processErrors, @
    # options
    @theater = options.theater
  
  className: "new-user"

  events:
    "click .fb-connect": "facebookConnect"
    "click a": "createUser"
    "keypress input": "keypress"
    
  facebookConnect: (event)->
    FB.login @facebookCallback, scope: $(event.target).data 'scope'
    
  facebookCallback: (response) =>
    if response.status == "connected"
      facebookToken = response.authResponse.accessToken
      @model.set facebookToken: facebookToken
      @model.fetch()
    
  keypress: (e) ->
    if (e.keyCode == 13)
      @createUser()
    
  createUser: (event)->
    event.preventDefault() if event
    
    # set params
    params = {}
    params["name"]      = @.$('input[name=name]').val()
    params["email"]     = @.$('input[name=email]').val()
    params["password"]  = @.$('input[name=password]').val()
    @model.set params
    # send
    @model.save success: @userCreated
    # errors
    @.$('ul.errors').html ''
    @.$('ul.errors').hide()
    
  userCreated: (user)=>
    @theater.close()
    
  processErrors: (user, response)->
    data = $.parseJSON response.responseText
    _.each data.response.errors, (errors, name) =>
      _.each errors, (error) =>
        text = "<li>#{name} #{error}</li>"
        @.$('ul.errors').append text
    # show
    @.$('ul.errors').fadeIn()
   
  render: ->
    $(@el).html Mustache.to_html($('#users-new-template').html())
    @