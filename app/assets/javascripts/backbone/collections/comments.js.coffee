class window.CommentsCollection extends Backbone.Collection
  
  initialize: (options) ->
    @proposition = options.proposition
  
  model: CommentModel

  url: ->
    "/api/v1/propositions/#{@proposition.id}/comments"

  parse: (response) ->
    response.response.comments