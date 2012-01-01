class window.TagsCollection extends Backbone.Collection
  
  model: TagModel

  search_tag: (tag_id) ->
    res = null
    res ||= @.find (tag) ->
      tag.id == tag_id
    res ||= @.reduce(
      (memo, tag) ->
        console.log 'dep'
        memo || tag.tags.search_tag tag_id
      null
    )
