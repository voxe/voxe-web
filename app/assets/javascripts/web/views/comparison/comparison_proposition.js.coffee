class window.ComparisonPropositionView extends Backbone.View
  
  initialize: ->
    @showComments = false
    @model.comments.bind "reset", @resetComments, @
    @model.bind 'change:commentsCount', @renderCommentsCount, @

    @candidacy = app.collections.candidacies.find (ca) => ca.id == @model.get('candidacy').id
  
  className: "proposition"
  
  events:
    "click .comments-count a": "showComments"
    "click .facebook": "facebook"
    "mouseover": "mouseOver"
    "mouseout": "mouseOut"
    
  resetComments: ->
    @.$('.comments-count a').removeClass "indicator"
    
  showComments: (e)->
    e.preventDefault()
    unless @showComments
      @showComments = true
      view = new CommentsView(model: @model)
      if @model.commentsCount() == 0
        view.render()
      else
        # indicator
        @.$('.comments-count a').addClass "indicator"
        @model.comments.fetch()
      $(@el).append view.el
      # focus
      @.$("textarea").focus()
  
  render: ->
    if @model.text().length > 60
      @model.set twitterMessage: "#{@candidacy.name()} : #{@model.text().slice(0,60)}... http://voxe.org"
    else
      @model.set twitterMessage: "#{@candidacy.name()} : #{@model.text()} http://voxe.org"
    $(@el).html Mustache.to_html($('#comparison-proposition-template').html(), proposition: @model.toJSON())
    # datavizs
    _.each @model.embeds.datavizs(), (embed) =>
      view = new PropositionEmbedView model: embed
      $(@el).prepend view.render().el
    # videos
    _.each @model.embeds.videos(), (embed) =>
      view = new PropositionEmbedView model: embed
      $(@el).prepend view.render().el
    # links
    links = @model.embeds.links()
    unless _.isEmpty links
      view = new PropositionEmbedLinksView collection: new EmbedsCollection links
      $('.text', @el).after view.render().el
    
    @renderCommentsCount()
    
    $('.share', @el).hide()

    @

  facebook: ->
    obj =
      method: 'feed'
      link: "http://voxe.org/propositions/#{@model.id}"

    FB.ui obj, (response)->
      if response['post_id']
        alert 'Envoye!'

  mouseOver: ->
    $('.share', @el).show()

  mouseOut: ->
    $('.share', @el).hide()

  renderCommentsCount: ->
    if @model.commentsCount() == 0
      text = "Commenter"
    else
      if @model.commentsCount() == 1
        text = "#{@model.commentsCount()} commentaire"
      else
        text = "#{@model.commentsCount()} commentaires"
    @.$('.comments-count a').html text
