class window.TagsListView extends Backbone.View
  
  tags: ->
    app.collections.tags.toJSON()
    
  election: ->
    app.models.election
  
  initialize: ->
    @election().bind "change", @render, @
  
  events:
    "click ul.tags li": "themeClick"
      
  themeClick: (e)->
    li = $(e.target).closest('li')
    tagId = li.attr("tag-id")
    tag = _.find app.models.election.tags(), (tag) ->
      tag.id == tagId
    app.models.tag.set tag
    
    app.router.compareView()
    
  render: ->
    $(@el).html Mustache.to_html($('#tags-list-template').html(), tags: @tags())
    @
    # new iScroll $('.table-view-container', @el).get(0)