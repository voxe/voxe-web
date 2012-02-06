class window.UserNewView extends Backbone.View
  
  initialize: (options)->
    @model.bind 'error', @processErrors, @
    # options
    @theater = options.theater
  
  className: "new-user"

  events:
    "click a": "createUser"
    "keypress input": "keypress"
    
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