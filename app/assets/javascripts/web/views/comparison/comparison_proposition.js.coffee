class window.ComparisonPropositionView extends Backbone.View
  
  initialize: ->
    @showComments = false
  
  className: "proposition"
  
  events:
    "click .comments a": "showComments"
    
  showComments: (e)->
    e.preventDefault()
    unless @showComments
      @showComments = true
      view = new CommentsView()
      $(@el).append view.render().el
  
  render: ->
    $(@el).html Mustache.to_html($('#comparison-proposition-template').html(), proposition: @model.toJSON())
    @