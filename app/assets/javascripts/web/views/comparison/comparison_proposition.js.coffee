class window.ComparisonPropositionView extends Backbone.View
  
  className: "proposition"
  
  # events:
  #   "click .proposition a": "addComment"
  #   
  # addComment: ->
  #   comment = new CommentModel()
  #   comment.set text: "hello comment!"
  #   comment.save()
  
  render: ->
    $(@el).html Mustache.to_html($('#comparison-proposition-template').html(), proposition: @model.toJSON())
    @