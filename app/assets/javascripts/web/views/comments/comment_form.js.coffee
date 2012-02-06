class window.CommentFormView extends Backbone.View
  
  initialize: (options)->
    # options
    @user = options.user
      
    @user.bind "change:token", @render, @
    
  events:
    "click a.button": "postComment"
  
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
    @.$('textarea').val ''
    
  render: ->
    $(@el).html Mustache.to_html($('#comment-form-template').html(), user: @user.toJSON())
    @