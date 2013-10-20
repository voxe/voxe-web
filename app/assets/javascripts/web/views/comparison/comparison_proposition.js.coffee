class window.ComparisonPropositionView extends Backbone.View

  initialize: ->
    @commentsDisplayed = false
    @model.comments.bind "reset", @resetComments, @
    @model.bind 'change:commentsCount', @renderCommentsCount, @

    @candidacy = app.collections.candidacies.find (ca) => ca.id == @model.get('candidacy').id

    @userActions = ["favorite", "support", "against"]
    _.each @userActions, (action) =>
      @model.bind "change:#{action}_users", @refresh, @

    @commentsView = new CommentsView(model: @model)

  className: "proposition"

  events:
    "click .actions .comment": "showComments"
    "click .favorite .btn": "toggleFavorite"
    "click .support .btn": "toggleSupport"
    "click .against .btn": "toggleAgainst"
    "click .facebook": "facebook"
    "mouseover": "mouseOver"
    "mouseout": "mouseOut"

  resetComments: ->
    @.$('.comments-count a').removeClass "indicator"

  showComments: (e) ->
    e?.preventDefault()
    @commentsView.show(fetch: true)

  render: ->
    # fix tipsy bug
    $('.tipsy').remove()

    @commentsDisplayed = false
    if @$('.comments .comment').is(':visible')
      @comment = @$('form textarea').val()

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

    _.each @userActions, (action) =>
      @$(".actions .#{action} .btn").addClass('active') if @model.isUserActioned(action)
      @$(".actions .#{action} .btn").tipsy()
      @$(".actions .#{action} .count").text @model.get("#{action}_users").count

    console.log @model.comments
    @$(".actions .comment .count").text @model.comments.length

    @$el.append @commentsView.render().el

    if @comment?
      @showComments()
      @$('form textarea').val @comment

    # @renderCommentsCount()

    @

  toggleUserAction: (action, e) ->
    e.preventDefault()
    $(e.currentTarget).toggleClass('active')
    @model.toggleUserAction(action)

  toggleFavorite: (e) -> @toggleUserAction('favorite', e)
  toggleSupport: (e) -> @toggleUserAction('support', e)
  toggleAgainst: (e) -> @toggleUserAction('against', e)

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
        text = "#{@model.commentsCount()} comment"
      else
        text = "#{@model.commentsCount()} comments"
    @.$('.comments-count a').html text

  refresh: ->
    @model.fetch
      success: =>
        @render()
