class window.CommentModel extends Backbone.Model
  
  initialize: (options)->
    @proposition = options.proposition
  
  url: ->
    "/api/v1/propositions/#{@proposition.id}/addcomment"
  
  parse: (response) ->
    response.response.comment