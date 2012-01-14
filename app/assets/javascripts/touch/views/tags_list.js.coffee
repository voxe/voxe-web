class window.TagsListView extends Backbone.View
  
  initialize: ->
    @model.bind "change", @render, @
    
  events:
    "click a.nav": "candidaciesClick"
    "click ul.tags li": "themeClick"
    
  candidaciesClick: ->
    app.router.navigate "#{@model.namespace()}", true
      
  themeClick: (e)->
    li = $(e.target).closest('li')
    tagId = li.attr("tag-id")
    tag = _.find @model.tags.models, (tag) ->
      tag.id == tagId
    app.models.tag.set tag.toJSON()
    app.router.navigate "#{@model.namespace()}/#{@model.candidacies.toParam()}/#{tag.namespace()}", true
    
  render: ->
    $(@el).html Mustache.to_html($('#tags-list-template').html(), tags: @model.tags.toJSON())
    new iScroll $('.table-view-container', @el).get(0)
    setTimeout hideURLbar, 0
    @