class window.UserProfileView  extends Backbone.View
  
  id: "user-profile"
  
  tagName: "li"
  
  events:
    "click .connect": "connect"
    "click .logout": "logout"
    "click .edit-profile": "edit"
    
  logout: (e)->
    e.preventDefault()
    
    $(e.target).tipsy "hide"
    @model.logout()
    
  connect: (e)->
    e.preventDefault()
    
    view = new SessionView(model: app.models.user)
    view.render()

  edit: (e) ->
    e.preventDefault()

    view = new EditUserProfileView(model: app.models.user)
    view.render()

  initialize: ->
    @model.bind "change", @render, @
    
  render: ->
    $(@el).html Mustache.to_html($('#user-profile-template').html(), user: @model.toJSON())
    @