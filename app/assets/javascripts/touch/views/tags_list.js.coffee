class window.TagsListView extends Backbone.View
  
  tags: ->
    app.collections.tags.toJSON()
    
  election: ->
    app.models.election
  
  initialize: ->
    @election().bind "change", @render, @
  
  events:
    "click a.nav": "candidaciesClick"
    "click ul.tags li": "themeClick"
    
  candidaciesClick: ->
    app.router.navigate "#{app.models.election.namespace()}", true
      
  themeClick: (e)->
    li = $(e.target).closest('li')
    tagId = li.attr("tag-id")
    tag = _.find app.models.election.tags.models, (tag) ->
      tag.id == tagId
    app.models.tag.set tag.toJSON()
    
    app.router.navigate "#{app.models.election.namespace()}/#{app.models.election.candidacies.toParam()}/#{tag.namespace()}", true
    
  render: ->
    $(@el).html Mustache.to_html($('#tags-list-template').html(), tags: @tags())
    new iScroll $('.table-view-container', @el).get(0)
    @