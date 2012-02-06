class window.PropositionModel extends Backbone.Model
  
  # http://voxe.org/platform/models/proposition
  
  initialize: ->
    @comments = new CommentsCollection(proposition: @)
    
  commentsCount: ->
    @get("comments").count
  
  candidacy: ->
    @get "candidacy"
  
  candidacies: ->
    @get "candidacies"
  
  tags: ->
    @get "tags"
    
  id: ->
    @get "id"
    
  text: ->
    @get "text"

  url: ->
    "/api/v1/propositions/#{@id}"

  parse: (response) ->
    response.response.proposition

  addEmbed: (url) ->
    model = @
    $.ajax
      type: 'POST'
      url: "#{@url()}/addembed"
      data: {url: url}
      success: (response) ->
        model.set embeds: response.response.proposition.embeds

  removeEmbed: (embedId) ->
    model = @
    $.ajax
      type: 'DELETE'
      url: "#{@url()}/removeembed"
      data: {embedId: embedId}
      complete: (response) ->
        if response.status == 200
          # sync collection with server
          embeds = model.get 'embeds'
          model.set embeds: _.reject(embeds, (e) -> e.id == embedId)
