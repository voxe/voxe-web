class window.UserProfileView  extends Backbone.View
  
  id: "user-profile"
  
  tagName: "li"
  
  events:
    "click .connect": "connect"
    
  connect: ->
    view = new SessionView(model: app.models.user)
    view.render()
  
  initialize: ->
    @model.bind "change:name", @render, @
    
  render: ->
    $(@el).html Mustache.to_html($('#user-profile-template').html(), user: @model.toJSON())
    @