class window.TagsListView extends Backbone.View
  
  initialize: ->
    @collection.bind "reset", @render, @
  
  events:
    "click ul li": "tagClick"
      
  tagClick: (e)->
    $li = $(e.target).closest('li')
    $li.addClass 'selected'
    
    tagId = $li.attr("tag-id")
    tag = _.find app.models.election.tags(), (tag) ->
      tag.id == tagId
    app.models.tag.set tag
    # app.router.compareView()
    
  render: ->
    $(@el).html Mustache.to_html($('#tags-list-template').html(), tags: @collection.toJSON())