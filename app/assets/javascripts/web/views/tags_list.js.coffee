class window.TagsListView extends Backbone.View
  
  tags: ->
    app.collections.tags.toJSON()
    
  election: ->
    app.models.election
  
  initialize: ->
    @election().bind "change", @render, @
    @last = null
  
  events:
    "click li": "themeClick"
      
  themeClick: (e)->
    tagId = $(e.currentTarget).attr("tag-id")
    if (tagId != @last)
      $('li div', @el).slideUp()
      @last = tagId
      $('div', e.currentTarget).slideToggle()
      tag = _.find app.models.election.tags.models, (tag) ->
        tag.id == tagId
      app.models.tag.set tag
    
  render: ->
    $(@el).html Mustache.to_html($('#tags-list-template').html().replace('&gt;', '>'), tags: @tags(), {"subtags": $('#subtags-list-template').html()})