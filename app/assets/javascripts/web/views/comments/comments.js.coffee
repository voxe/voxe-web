class window.CommentsView extends Backbone.View
  
  initialize: ->
    @model.comments.bind "add", @addComment, @
    @model.comments.bind "reset", @addComments, @
    @model.comments.bind 'destroy', (-> @trigger 'commentRemoved'), @
  
  events:
    "click a.session": "newSession"
    
  newSession: (event)->
    event.preventDefault()
    # session
    view = new SessionView(model: app.models.user)
    view.render()
    
  addComments: (comments) ->
    @render()
    
    _.each comments.models, (comment) =>
      @addComment comment
    
  addComment: (comment) ->
    view = new CommentView model: comment
    @.$('.comments').append view.render().el
    
  render: ->
    $(@el).append Mustache.to_html($('#comments-template').html(), session: app.models.user.loggedIn())
    # comment form
    view = new CommentFormView user: app.models.user, model: @model
    $(@el).append view.render().el
    
    # focus
    @.$("textarea").focus()
    
    @