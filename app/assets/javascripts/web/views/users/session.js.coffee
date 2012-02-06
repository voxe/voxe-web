class window.SessionView  extends Backbone.View
  
  id: "session"
  
  render: ->
    @theater = new TheaterView()
    
    # new user
    view = new UserNewView(model: @model, theater: @theater)
    $(@el).append view.render().el
    
    # new session
    view = new SessionNewView(model: @model, theater: @theater)
    $(@el).append view.render().el
    
    # theater
    @theater.play @el
        
    @