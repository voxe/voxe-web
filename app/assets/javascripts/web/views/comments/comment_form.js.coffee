class window.CommentFormView extends Backbone.View
  tagName: 'form'

  initialize: (options)->
    # options
    @user = options.user
    @render()
      
    @user.bind "change:token", @render, @
    
  events:
    "click button": "postComment"
  
  postComment: (event) ->
    event.preventDefault()
    # blank
    text = @.$('textarea').val()
    return if text == ''
    
    # model
    comment = new CommentModel text: text, proposition: @model, user: @user.toJSON()
    comment.save()
    # add to collection
    @model.comments.add comment
    # reset textarea
    @$('textarea').val ''
    
  render: ->
    @comment = @$('textarea').val()
    @$el.html Mustache.to_html($('#comment-form-template').html(), user: @user.toJSON())
    @$('textarea').val @comment
    @
