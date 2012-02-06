class window.ComparisonPropositionView extends Backbone.View
  
  initialize: ->
    @showComments = false
    @model.comments.bind "reset", @resetComments, @
  
  className: "proposition"
  
  events:
    "click .comments-count a": "showComments"
    
  resetComments: ->
    @.$('.comments-count a').removeClass "indicator"
    
  showComments: (e)->
    e.preventDefault()
    unless @showComments
      @showComments = true
      view = new CommentsView(model: @model)
      if @model.commentsCount() == 0
        if app.models.user.loggedIn()
          view.render()
        else
          sessionView = new SessionView(model: app.models.user)
          sessionView.render()
      else
        # indicator
        @.$('.comments-count a').addClass "indicator"
        @model.comments.fetch()
      $(@el).append view.el
      # focus
      @.$("textarea").focus()
  
  render: ->
    $(@el).html Mustache.to_html($('#comparison-proposition-template').html(), proposition: @model.toJSON())
    # videos
    _.each @model.embeds.models, (embed) =>
      view = new PropositionEmbedView model: embed
      $(@el).prepend view.render().el
    
    # comments-count
    if @model.commentsCount() == 0
      text = "Commenter"
    else
      if @model.commentsCount() == 1
        text = "#{@model.commentsCount()} commentaire"
      else
        text = "#{@model.commentsCount()} commentaires"
    @.$('.comments-count a').prepend text
    
    @