class window.CommentView extends Backbone.View
  
  className: "comment"

  events:
    'mouseenter': 'showActions'
    'mouseleave': 'hideActions'
    'click a.remove': 'removeThisComment'
  
  initialize: ->
    @model.bind 'destroy', @remove, @

  render: ->
    $(@el).html Mustache.to_html($('#comment-template').html(), comment: @model.toJSON())

    @hideActions()

    @

  showActions: ->
    if (app.models.user.id is @model.get('user').id) or (app.models.user.get('admin'))
      $('.comment-actions', @el).show()

  hideActions: ->
    $('.comment-actions', @el).hide()

  removeThisComment: (event) ->
    event.preventDefault()

    comment = @model
    proposition = @model.collection.proposition
    @model.destroy url: "#{proposition.url()}/removecomment?auth_token=#{app.models.user.token()}", data: $.param({commentId: @model.id}), complete: (response) ->
      comment.trigger 'destroy' if response.status == 200
