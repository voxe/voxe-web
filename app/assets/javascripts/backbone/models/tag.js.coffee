class window.TagModel extends Backbone.Model
  
  # http://voxe.org/platform/models/tag
  
  initialize: ->
    @tags = new TagsCollection(@get 'tags', parent_tag: @)
    @tags.parent_tag = @

  iconUrl: (size) ->
    "pierre"
  
  tags: ->
    @get "tags"
  
  name: ->
    @get "name"
