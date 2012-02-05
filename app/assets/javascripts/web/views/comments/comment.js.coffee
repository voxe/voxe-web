class window.CommentView extends Backbone.View
  
  className: "comment"
  
  render: ->
    $(@el).html Mustache.to_html($('#comment-template').html(), comment: @model.toJSON())
    @