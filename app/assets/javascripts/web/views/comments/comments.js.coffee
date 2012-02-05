class window.CommentsView extends Backbone.View
  
  events:
    "click a.button": "addComment"
    
  addComment: (e)->
    e.preventDefault()
    # model
    comment = new CommentModel text: @.$('textarea').val()
    
    view = new CommentView model: comment
    $(@el).append view.render().el
    
    @.$('textarea').val ''
    
  render: ->
    $(@el).html Mustache.to_html($('#comments-template').html())
    @