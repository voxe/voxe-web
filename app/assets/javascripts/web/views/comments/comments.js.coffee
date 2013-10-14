class window.CommentsView extends Backbone.View
  className: 'comments'

  initialize: ->
    @model.comments.bind "add", @render, @
    @model.comments.bind "reset", @render, @
    @model.comments.bind 'destroy', (-> @trigger 'commentRemoved'), @
    @commentFormView = new CommentFormView user: app.models.user, model: @model
    @$el.hide()

  events:
    "click a.session": "newSession"

  show: (options) ->
    @$el.show()
    if options.fetch then @model.comments.fetch()

  newSession: (event)->
    event.preventDefault()
    # session
    view = new SessionView(model: app.models.user)
    view.render()

  addComment: (comment) ->
    view = new CommentView model: comment
    @commentFormView.$el.before view.render().el

  render: ->
    @$el.html ""
    $(@el).append @commentFormView.el
    @model.comments.each (comment) =>
      @addComment comment

    @
