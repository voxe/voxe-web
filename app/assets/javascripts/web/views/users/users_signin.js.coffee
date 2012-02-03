class window.UsersSigninView extends Backbone.View
  
  initialize: ->    
    @model.bind 'error', @processErrors
  
  className: "modal"

  events:
    "click a": "createSession"
    
  createSession: (event)->
    event.preventDefault()
    
    # set params
    params = {}
    params["email"]     = @.$('input[name=email]').val()
    params["password"]  = @.$('input[name=password]').val()
    @model.session.set params
    
    # send
    @model.session.save()
    
  processErrors: ->
    alert 'ok'
        
  render: ->
    $(@el).html Mustache.to_html($('#users-signin-template').html())
    @