class window.SessionNewView extends Backbone.View
  
  initialize: (options)->    
    @model.bind 'change:token', @sessionCreated, @
    # options
    @theater = options.theater
  
  className: "new-session"

  events:
    "click a": "createSession"
    "keypress input": "keypress"
    
  keypress: (e) ->
    if (e.keyCode == 13)
      @createSession()
    
  createSession: (event)->
    event.preventDefault() if event
    
    # send
    @.$('ul.errors').html ""
    email = @.$('input[name=email]').val()
    password = @.$('input[name=password]').val()
    @model.session.fetch data: {email: email, password: password}, success: @sessionCreated, error: @processErrors
    
  sessionCreated: =>
    @theater.close()
    
  processErrors: =>
    @.$('ul.errors').html "<li>Email et/ou mot de passe invalide(s)</li>"
    # show
    @.$('ul.errors').fadeIn()
        
  render: ->
    $(@el).html Mustache.to_html($('#users-signin-template').html())
    @