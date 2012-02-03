class window.UsersNewView extends Backbone.View
  
  initialize: ->
    @model.bind 'error', @processErrors
  
  className: "modal"

  events:
    "click a": "createUser"
    
  createUser: (event)->
    event.preventDefault()
    # set params
    params = {}
    params["name"]      = @.$('input[name=name]').val()
    params["email"]     = @.$('input[name=email]').val()
    params["password"]  = @.$('input[name=password]').val()
    @model.set params
    # send
    @model.save()
    
  processErrors: ->
    alert 'ok'
        
  render: ->
    $(@el).html Mustache.to_html($('#users-new-template').html())
    @