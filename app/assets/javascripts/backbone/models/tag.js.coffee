class window.TagModel extends Backbone.Model
  
  # http://voxe.org/platform/models/tag
  
  iconUrl: (size) ->
    "pierre"
  
  tags: ->
    @get "tags"
  
  name: ->
    @get "name"