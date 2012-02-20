class window.TagModel extends Backbone.Model
  
  # http://voxe.org/platform/models/tag
  
  defaults:
    "selected": false

  url: ->
    if @id
      "/api/v1/tags/#{@id}"
    else
      "/api/v1/tags/"

  initialize: ->
    @.bind 'error', @processErrors
    @tags = new TagsCollection(@get 'tags', parent_tag: @)
    @tags.parent_tag = @
    @bind "change:tags", (tag) =>
      @tags.reset tag.get 'tags'

  iconUrl: (size) ->
    "pierre"
  
  name: ->
    @get "name"
    
  namespace: ->
    @get "namespace"
    
  isSelected: ->
    @get('selected') == true

  parent: ->
    if @collection and @collection.parent_tag
      @collection.parent_tag
    else
      undefined

  parents: ->
    if @collection and @collection.parent_tag
      parents = @collection.parent_tag.parents()
      parents.push @collection.parent_tag
      parents
    else new Array()

  parse: (response) ->
    response.response.tag

  processErrors: (tag, response) ->
    errors = ($.parseJSON response.responseText).response.errors
    @.error_messages = _.reduce errors,
      (memo, messages, attribute) ->
        _.each messages,
          (message) -> memo.push("#{attribute} #{message}")
        memo
      []
